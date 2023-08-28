
using Distributed
addprocs(2, exeflags="--project=$(Base.active_project())")
@everywhere include("src/Stella.jl")
@everywhere using .Stella
port = parse(Int, ARGS[1])
grpcserver = "http://localhost:$port/"


# julia --project main.jl 50051
function main()
    @sync begin
        @spawn begin
            # ゲームの実行
            ai = DeepAI()
            main = ai.model
            warmup(main.model, main.ps, main.st)
            while true
                try
                    ai_player(grpcserver, ai, true, "Stella")
                    GC.gc()
                catch e
                    @error exception = (e, stacktrace(catch_backtrace()))
                end
            end
        end
    end
end

main()
