data = readlines("data/day10")

const openers, clozers = "([{<", ")]}>"
const closers = Dict(zip(openers, clozers))
const scores = Dict(zip(clozers, [3 57 1197 25137]))
const valscores = Dict(zip(openers, 1:4))

function scorechunks(data::Array)
    s, validscores = 0, []
    for l in data
        openchunks, v = [], true
        for c in l
            if c in openers
                append!(openchunks, c)
            else
                if get(closers, openchunks[end], 'a') == c
                    pop!(openchunks)
                else
                    s += scores[c]
                    v = false
                    break
                end
            end
        end
        if v
            cs = 0
            # complete valid chunks
            for i in length(openchunks):-1:1
               cs = (5*cs) + valscores[openchunks[i]]
            end
            append!(validscores, cs)
        end
    end
    s, sort(validscores)[length(validscores)÷2+1]
end
println(scorechunks(data))