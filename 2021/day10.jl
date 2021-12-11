data = readlines("data/day10")

const openers, clozers = "([{<", ")]}>"
const closers = Dict(zip(openers, clozers))
const scores = Dict(zip(clozers * openers, [3 57 1197 25137 1 2 3 4]))

function scorechunks(data::Array)
    s, validscores = 0, []
    for l in data
        openchunks = []
        for c in l
            if c in openers append!(openchunks, c)
            else
                if closers[last(openchunks)] == c pop!(openchunks)
                else s += scores[c]; @goto corrupted
                end
            end
        end
        cs = 0
        for i in length(openchunks):-1:1
           cs = (5*cs) + scores[openchunks[i]]
        end
        append!(validscores, cs)
        @label corrupted
    end
    s, sort(validscores)[length(validscores)÷2+1]
end
println(scorechunks(data))