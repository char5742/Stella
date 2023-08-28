module Stella
using JLD2
using JuliaFtg
using Random
using Lux
using MLUtils
using Zygote
using StatsBase

include("action.jl")
include("network.jl")
include("predicter.jl")
include("ai.jl")
export DeepAI, warmup, ai_player
end # module Stella