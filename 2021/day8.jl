using StatsBase

data = split.(readlines("data/day8"), " | ")
function part1(data::Array, targets=[2 3 4 7])
    c = 0
    for (_, out) in data
        c += sum(indexin(length.(split(out, " ")), targets) .!= nothing)
    end
    c
end
#println(part1(data))

function stoi(t::String)
    if t == "abcefg"
        return 0
    elseif t == "cf"
        return 1
    elseif t == "acdeg"
        return 2
    elseif t == "acdfg"
        return 3
    elseif t == "bcdf"
        return 4
    elseif t == "abdfg"
        return 5
    elseif t == "abdefg"
        return 6
    elseif t == "acf"
        return 7
    elseif t == "abcdefg"
        return 8
    else
        return 9
    end
end

function buildmap(seq)
    mapping = Dict{Char, Char}()
    subseq = split(seq, " ")
    c = countmap(join(subseq))
    # a=8,c=8, b=6, d=7,g=7, e=4, f=9
    # we can always know what maps to e, f, b. Because they have unique counts
    for (k,v) in c
        if v == 4
            mapping['e'] = k
        elseif v == 6
            mapping['b'] = k
        elseif v == 9
            mapping['f'] = k
        end
    end
    mapping['c'] = setdiff(String(filter(x->length(x) == 2, subseq)[1]), String([mapping['f']]))[1]
    mapping['d'] = setdiff(filter(x->length(x) == 4, subseq)[1], values(mapping))[1]
    mapping['a'] = setdiff(filter(x->length(x) == 3, subseq)[1], values(mapping))[1]
    mapping['g'] = collect(setdiff("abcdefg", String(collect(values(mapping)))))[1]

    Dict(v=>k for (k,v) in mapping)
end

function part2(data::Array)
    total = 0
    for (seq, out) in data
        mapping = buildmap(seq)
        mappedtext = join.(sort.(collect.(map.(x->get(mapping, x, x), split(out, " ")))))
        digits = []
        for t in mappedtext
            push!(digits, stoi(t))
        end
        total += parse(Int, join(digits))
    end
    total
end


println(part2(data))