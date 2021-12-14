data = readlines("data/day14")
template, pairs = data[1], Dict(Tuple.(split.(data[3:end], " -> ")))

function evaluate2(template::String, pairs::Dict{SubString{String}, SubString{String}}, steps::Int)
    d = Dict{String, Int64}()
    for s in join.(zip(template, template[2:end]))
        if haskey(d, s) d[s] += 1
        else d[s] = 1 end
    end
    for gen in 1:steps
        existing, d = copy(d), Dict{String, Int64}()
        for (seq, counts) in existing
            middle = pairs[seq]
            for s in [join([seq[1], middle]), join([middle, seq[2]])]
                if haskey(d, s) d[s] += counts
                else d[s] = counts end
            end
        end
    end
    d
end

cs = Dict{Char, Int64}()
out = evaluate2(template, pairs, 40)
for (seq, c) in out
    for s in seq
        if haskey(cs, s) cs[s] += c
        else cs[s] = c end
    end
end
println((maximum(values(cs))÷2) - (minimum(values(cs))÷2) + 1)
println(cs)