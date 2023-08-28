module Action
@enum ActionEnum begin
    NEUTRAL
    # STAND
    FORWARD_WALK
    DASH
    BACK_STEP
    CROUCH
    JUMP
    FOR_JUMP
    BACK_JUMP
    # AIR
    STAND_GUARD
    CROUCH_GUARD
    # AIR_GUARD
    # STAND_GUARD_RECOV
    # CROUCH_GUARD_RECOV
    # AIR_GUARD_RECOV
    # STAND_RECOV
    # CROUCH_RECOV
    # AIR_RECOV
    # CHANGE_DOWN
    # DOWN
    # RISE
    # LANDING
    THROW_A
    THROW_B
    # THROW_HIT
    # THROW_SUFFER
    STAND_A
    STAND_B
    CROUCH_A
    CROUCH_B
    AIR_A
    AIR_B
    AIR_DA
    AIR_DB
    STAND_FA
    STAND_FB
    CROUCH_FA
    CROUCH_FB
    AIR_FA
    AIR_FB
    AIR_UA
    AIR_UB
    STAND_D_DF_FA
    STAND_D_DF_FB
    STAND_F_D_DFA
    STAND_F_D_DFB
    STAND_D_DB_BA
    STAND_D_DB_BB
    AIR_D_DF_FA
    AIR_D_DF_FB
    AIR_F_D_DFA
    AIR_F_D_DFB
    AIR_D_DB_BA
    AIR_D_DB_BB
    STAND_D_DF_FC
end
export ActionEnum
end

function convert_to_native(action::Action.ActionEnum)::Struct.Action.ActionEnum
    if action == Action.NEUTRAL
        return Struct.Action.NEUTRAL
    elseif action == Action.STAND
        return Struct.Action.STAND
    elseif action == Action.FORWARD_WALK
        return Struct.Action.FORWARD_WALK
    elseif action == Action.DASH
        return Struct.Action.DASH
    elseif action == Action.BACK_STEP
        return Struct.Action.BACK_STEP
    elseif action == Action.CROUCH
        return Struct.Action.CROUCH
    elseif action == Action.JUMP
        return Struct.Action.JUMP
    elseif action == Action.FOR_JUMP
        return Struct.Action.FOR_JUMP
    elseif action == Action.BACK_JUMP
        return Struct.Action.BACK_JUMP
    elseif action == Action.AIR
        return Struct.Action.AIR
    elseif action == Action.STAND_GUARD
        return Struct.Action.STAND_GUARD
    elseif action == Action.CROUCH_GUARD
        return Struct.Action.CROUCH_GUARD
    elseif action == Action.AIR_GUARD
        return Struct.Action.AIR_GUARD
    elseif action == Action.STAND_GUARD_RECOV
        return Struct.Action.STAND_GUARD_RECOV
    elseif action == Action.CROUCH_GUARD_RECOV
        return Struct.Action.CROUCH_GUARD_RECOV
    elseif action == Action.AIR_GUARD_RECOV
        return Struct.Action.AIR_GUARD_RECOV
    elseif action == Action.STAND_RECOV
        return Struct.Action.STAND_RECOV
    elseif action == Action.CROUCH_RECOV
        return Struct.Action.CROUCH_RECOV
    elseif action == Action.AIR_RECOV
        return Struct.Action.AIR_RECOV
    elseif action == Action.CHANGE_DOWN
        return Struct.Action.CHANGE_DOWN
    elseif action == Action.DOWN
        return Struct.Action.DOWN
    elseif action == Action.RISE
        return Struct.Action.RISE
    elseif action == Action.LANDING
        return Struct.Action.LANDING
    elseif action == Action.THROW_A
        return Struct.Action.THROW_A
    elseif action == Action.THROW_B
        return Struct.Action.THROW_B
    elseif action == Action.THROW_HIT
        return Struct.Action.THROW_HIT
    elseif action == Action.THROW_SUFFER
        return Struct.Action.THROW_SUFFER
    elseif action == Action.STAND_A
        return Struct.Action.STAND_A
    elseif action == Action.STAND_B
        return Struct.Action.STAND_B
    elseif action == Action.CROUCH_A
        return Struct.Action.CROUCH_A
    elseif action == Action.CROUCH_B
        return Struct.Action.CROUCH_B
    elseif action == Action.AIR_A
        return Struct.Action.AIR_A
    elseif action == Action.AIR_B
        return Struct.Action.AIR_B
    elseif action == Action.AIR_DA
        return Struct.Action.AIR_DA
    elseif action == Action.AIR_DB
        return Struct.Action.AIR_DB
    elseif action == Action.STAND_FA
        return Struct.Action.STAND_FA
    elseif action == Action.STAND_FB
        return Struct.Action.STAND_FB
    elseif action == Action.CROUCH_FA
        return Struct.Action.CROUCH_FA
    elseif action == Action.CROUCH_FB
        return Struct.Action.CROUCH_FB
    elseif action == Action.AIR_FA
        return Struct.Action.AIR_FA
    elseif action == Action.AIR_FB
        return Struct.Action.AIR_FB
    elseif action == Action.AIR_UA
        return Struct.Action.AIR_UA
    elseif action == Action.AIR_UB
        return Struct.Action.AIR_UB
    elseif action == Action.STAND_D_DF_FA
        return Struct.Action.STAND_D_DF_FA
    elseif action == Action.STAND_D_DF_FB
        return Struct.Action.STAND_D_DF_FB
    elseif action == Action.STAND_F_D_DFA
        return Struct.Action.STAND_F_D_DFA
    elseif action == Action.STAND_F_D_DFB
        return Struct.Action.STAND_F_D_DFB
    elseif action == Action.STAND_D_DB_BA
        return Struct.Action.STAND_D_DB_BA
    elseif action == Action.STAND_D_DB_BB
        return Struct.Action.STAND_D_DB_BB
    elseif action == Action.AIR_D_DF_FA
        return Struct.Action.AIR_D_DF_FA
    elseif action == Action.AIR_D_DF_FB
        return Struct.Action.AIR_D_DF_FB
    elseif action == Action.AIR_F_D_DFA
        return Struct.Action.AIR_F_D_DFA
    elseif action == Action.AIR_F_D_DFB
        return Struct.Action.AIR_F_D_DFB
    elseif action == Action.AIR_D_DB_BA
        return Struct.Action.AIR_D_DB_BA
    elseif action == Action.AIR_D_DB_BB
        return Struct.Action.AIR_D_DB_BB
    elseif action == Action.STAND_D_DF_FC
        return Struct.Action.STAND_D_DF_FC
    else
        error("Invalid action")
    end
end

"""
State, Energy状態に応じて行動をマスクする
"""
function action_mask(inair::Bool, energy::Float32, iscontrol::Bool)::Vector{Int64}
    energy *= 200
    res = zeros(Int64, length(instances(Action.ActionEnum)))
    if !iscontrol
        res[Int(Action.NEUTRAL)+1] = 1
        return res
    end
    if inair
        res[Int(Action.AIR_A)+1] = 1
        res[Int(Action.AIR_B)+1] = 1
        res[Int(Action.AIR_DA)+1] = 1
        res[Int(Action.AIR_DB)+1] = 1
        res[Int(Action.AIR_FA)+1] = 1
        res[Int(Action.AIR_FB)+1] = 1
        res[Int(Action.AIR_UA)+1] = 1
        res[Int(Action.AIR_UB)+1] = 1
        energy < 5 && return res
        res[Int(Action.AIR_D_DF_FA)+1] = 1
        energy < 10 && return res
        res[Int(Action.AIR_D_DB_BA)+1] = 1
        res[Int(Action.AIR_F_D_DFA)+1] = 1
        energy < 20 && return res
        res[Int(Action.AIR_D_DF_FB)+1] = 1
        energy < 40 && return res
        res[Int(Action.AIR_F_D_DFB)+1] = 1
        energy < 50 && return res
        res[Int(Action.AIR_D_DB_BB)+1] = 1
    else
        res[Int(Action.FORWARD_WALK)+1] = 1
        res[Int(Action.DASH)+1] = 1
        res[Int(Action.BACK_STEP)+1] = 1
        res[Int(Action.CROUCH)+1] = 1
        res[Int(Action.JUMP)+1] = 1
        res[Int(Action.FOR_JUMP)+1] = 1
        res[Int(Action.BACK_JUMP)+1] = 1
        res[Int(Action.STAND_GUARD)+1] = 1
        res[Int(Action.CROUCH_GUARD)+1] = 1
        res[Int(Action.STAND_A)+1] = 1
        res[Int(Action.STAND_B)+1] = 1
        res[Int(Action.CROUCH_A)+1] = 1
        res[Int(Action.CROUCH_B)+1] = 1
        res[Int(Action.STAND_FA)+1] = 1
        res[Int(Action.STAND_FB)+1] = 1
        res[Int(Action.CROUCH_FA)+1] = 1
        res[Int(Action.CROUCH_FB)+1] = 1
        res[Int(Action.STAND_F_D_DFA)+1] = 1
        res[Int(Action.STAND_D_DB_BA)+1] = 1
        energy < 5 && return res
        res[Int(Action.THROW_A)+1] = 1
        res[Int(Action.STAND_D_DF_FA)+1] = 1
        energy < 10 && return res
        res[Int(Action.THROW_B)+1] = 1
        energy < 30 && return res
        res[Int(Action.STAND_D_DF_FB)+1] = 1
        energy < 50 && return res
        res[Int(Action.STAND_D_DB_BB)+1] = 1
        energy < 55 && return res
        res[Int(Action.STAND_F_D_DFB)+1] = 1
        energy < 150 && return res
        res[Int(Action.STAND_D_DF_FC)+1] = 1
    end
    res
end