function loadmodel(path::String)::Model
    data = load(path)
    ps = data["ps"]
    st = data["st"]
    model = QNetwork(32, 41)
    Model(model, ps, st)
end

function create_carry()
    carry_size = 512
    (zeros(Float32, carry_size), zeros(Float32, carry_size))
end

function warmup(model, ps, st)
    model(
        (zeros(Float32, 96, 64, 1, 1), zeros(Float32, 5, 1), create_carry(), zeros(Float32, 41, 1), zeros(Float32, 1, 1)), ps, st)
end


mutable struct DeepAI <: AIInterface
    model::Model
    point::Union{Nothing,PointData}
    carry::Tuple{Vector{Float32},Vector{Float32}}
    prev_action::Action.ActionEnum
    iscontrol::Bool
    frame_skip_count::Int64
    blind_flag::Bool
    cc::CommandCenter
    key::Struct.Key
    player_number::Bool
    frame_data::Union{Nothing,Struct.FrameData}
    screen_data::Union{Nothing,Struct.ScreenData}
    audio_data::Union{Nothing,Struct.AudioData}
end

DeepAI(
) = DeepAI(loadmodel("mainmodel.jld2"),
    nothing, create_carry(), Action.NEUTRAL, false, 0,
    false, CommandCenter(), Struct.Key(), true, nothing, nothing, nothing)


function JuliaFtg.name(ai::DeepAI)
    string(typeof(ai))
end


function JuliaFtg.is_blind(ai::DeepAI)
    return ai.blind_flag
end

function JuliaFtg.initialize!(ai::DeepAI, game_data::Struct.GameData, player_number::Bool)
    ai.cc = CommandCenter()
    ai.key = Struct.Key()
    ai.player_number = player_number
    ai.point = nothing
    ai.carry = create_carry()
    ai.prev_action = Action.NEUTRAL
    ai.iscontrol = false
    ai.frame_skip_count = 0
end

function JuliaFtg.input(ai::DeepAI)
    ai.key
end

function JuliaFtg.get_information!(ai::DeepAI, frame_data::Struct.FrameData, is_control::Bool, non_delay_frame_data::Union{Nothing,Struct.FrameData})
    ai.iscontrol = is_control
    ai.frame_data = frame_data
    set_frame_data!(ai.cc, frame_data, ai.player_number)
    self_index = ai.player_number ? 1 : 2
    op_index = ai.player_number ? 2 : 1
    if non_delay_frame_data !== nothing
        self_character = non_delay_frame_data.character_data[self_index]
        op_character = non_delay_frame_data.character_data[op_index]
        current_frame = non_delay_frame_data.current_frame_number
    else
        self_character = frame_data.character_data[self_index]
        op_character = frame_data.character_data[op_index]
        current_frame = frame_data.current_frame_number
    end
    ai.point = PointData(
        self_character.hp / 400,
        op_character.hp / 400,
        self_character.energy / 200,
        op_character.energy / 200,
        self_character.state == Struct.State.AIR,
        current_frame / 3600,
        is_control,)
end

function JuliaFtg.get_screen_data!(ai::DeepAI, screen_data::Struct.ScreenData)
    ai.screen_data = screen_data

end

function JuliaFtg.get_audio_data!(ai::DeepAI, audio_data::Struct.AudioData)
    ai.audio_data = audio_data
end

function JuliaFtg.processing!(ai::DeepAI)
    ai.frame_skip_count += 1
    if ai.frame_data.empty_flag || ai.frame_data.current_frame_number <= 0
        return
    end
    if get_skill_flag(ai.cc)
        ai.key = get_skill_key(ai.cc)
        return
    end
    if ai.key.A || ai.key.B || ai.key.C
        ai.key = Struct.Key()
    end

    if mod(ai.frame_skip_count, 4) == 0 || ai.iscontrol
        ai.frame_skip_count = 0
        try

            skill_cancel!(ai.cc)
            action, carry = select_action(ai.model,
                ai.point,
                ai.screen_data,
                ai.carry,
                ai.prev_action,
            )
            ai.carry = carry
            ai.prev_action = action
            if action != Action.NEUTRAL
                command_call!(ai.cc, string(action))
            end
        catch e
            @error exception = (stacktrace(catch_backtrace()))
        end
    end
end

function JuliaFtg.round_end!(ai::DeepAI, round_result::Struct.RoundResult)
end

function JuliaFtg.game_end!(ai::DeepAI)
    GC.gc()
end

