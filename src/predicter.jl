struct Model
    model
    ps
    st
end

struct PointData
    hp::Float32
    hp_op::Float32
    energy::Float32
    energy_op::Float32
    inair::Bool
    current_frame::Float32
    iscontrol::Bool
end


const displaywidth = 96
const displayheight = 64
const displaydepth = 1
function display_to_pixel(display::Vector{UInt8})::Array{Float32,3}
    [
        display[(i-1)*displaywidth*displayheight+(k-1)*displaywidth+j] for k in 1:displayheight, j in 1:displaywidth, i in 1:displaydepth
    ] .|> Float32
end


function action_onehot(action::Action.ActionEnum)::Vector{Float32}
    action_num = length(instances(Action.ActionEnum))
    res = zeros(Float32, action_num)
    res[Int(action)+1] = 1.0
    res
end

function select_action(
    model::Model,
    point::PointData,
    screen::Struct.ScreenData,
    carry::Tuple{Vector{Float32},Vector{Float32}},
    prev_action::Action.ActionEnum,
)::Tuple{Action.ActionEnum,Tuple{Vector{Float32},Vector{Float32}}}
    # ここで displayheight * displaywidth * displaydepth * 1 の配列に変換する
    points_array = [[point.hp, point.hp_op, point.energy, point.energy_op, point.current_frame];;]
    screens_array = reshape(display_to_pixel(screen.display_bytes), displayheight, displaywidth, displaydepth, 1)
    score_list, carry_array = predict(model,
        (screens_array, points_array, ([carry[1];;], [carry[2];;]), [action_onehot(prev_action);;], [0.0f0;;])
    )
    mask = action_mask(point.inair, point.energy, point.iscontrol)
    m = [score_list[i] for i in eachindex(mask) if mask[i] == 1]
    @show sum(m) / length(m)
    index = argmax(i -> score_list[i], [i for i in eachindex(mask) if mask[i] == 1])
    @show Action.ActionEnum(index - 1)
    return Action.ActionEnum(index - 1), (carry_array[1][:], carry_array[2][:])
end


function predict(model,
    (state, point, carry, action, reward)::Tuple{Array{T,4},Array{T,2},Tuple{Array{T,2},Array{T,2}},Array{T,2},Array{T,2}}
) where {T}
    data = (state, point, carry, action, reward) |> gpu
    response, _ = model.model(data, model.ps, model.st) .|> cpu
    response
end
