
function DisplayNet(kernel_size)
    return Chain(
        # 96*64
        Conv((8, 8), 1 => kernel_size, swish; stride=4),
        # 20*12
        Conv((4, 4), kernel_size => kernel_size * 2, swish; stride=2),
        # 10*6
        Conv((3, 3), kernel_size * 2 => kernel_size * 2, swish; stride=1),
        # 8*4
        flatten,
    )
end


function RNNNet(hidden_num, rnn_num)
    Chain(
        LSTMCell(hidden_num => rnn_num),
    )
end


struct _QNetwork <: Lux.LuxCore.AbstractExplicitContainerLayer{(:display_net, :rnn_net, :score_net)}
    display_net
    rnn_net
    score_net
end
Base.getindex(m::_QNetwork, i) = i == 1 ? m.display_net() : m.score_net()
function (m::_QNetwork)((x, point, carry, prev_action, prev_reward), ps, st)
    x = x ./ 256.0f0
    board_feature, st_ = m.display_net(x, ps.display_net, st.display_net)
    st = merge(st, (display_net=st_,))
    y = vcat(board_feature, point, prev_action, prev_reward)
    (rnn_feature, carry), st_ = m.rnn_net((y, carry), ps.rnn_net, st.rnn_net)
    st = merge(st, (rnn_net=st_,))
    score, st_ = m.score_net(rnn_feature, ps.score_net, st.score_net)
    st = merge(st, (score_net=st_,))
    (score, carry), st
end


function QNetwork(kernel_size::Int64, action_num::Int64)
    carry_size = 512
    Chain(
        _QNetwork(
            DisplayNet(kernel_size),
            RNNNet(8 * 4 * kernel_size * 2 + 5 + action_num + 1, carry_size),
            ScoreNet(carry_size, action_num),
        )
    )
end


function ResNetBlock(n)
    layers = Chain(
        Conv((3, 3), n => n, pad=SamePad()),
        BatchNorm(n),
        swish,
        Conv((3, 3), n => n, pad=SamePad()),
        BatchNorm(n),
    )

    return Chain(SkipConnection(layers, +), swish)
end



function se_block(ch, ratio=4)
    layers = Chain(
        GlobalMeanPool(),
        Conv((1, 1), ch => ch ÷ ratio, swish),
        Conv((1, 1), ch ÷ ratio => ch, sigmoid),
    )
    return Chain(SkipConnection(layers, .*))
end


function reduce_mean(x)
    x .- Zygote.dropgrad(mean(x, dims=1))
end


function ScoreNet(feature_size, action_num)
    Chain(
        BranchLayer(
            Chain(Dense(feature_size => 512, swish), Dense(512 => 1)),# 45, 46
            Chain(Dense(feature_size => 512, swish), Dense(512 => action_num)),# 45, 46
        ),
        Parallel(
            .+,
            NoOpLayer(),
            WrappedFunction(reduce_mean),
        )
    )
end
