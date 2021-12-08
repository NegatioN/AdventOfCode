using StatsBase

data = split.(readlines("data/day8test"), " | ")
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
    mapping = Dict()
    subseq = split(seq, " ")
    c = countmap(join(subseq))
    # counts for initial setup, max=10
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
    # length 6 == zero, six, nine, only zero has 'd' unset. Which means we can find both g and d?
    # the letter which has 7 count overall, but only 2 counts in the group of length==6 strings? zero, six and nine
    d_candidates = collect(keys(c))[values(c) .== 7]

    sixletter_words = filter(x->length(x) == 6, subseq)
    d_check = countmap(join(sixletter_words))
    mapping['d'], mapping['g'] = d_check[d_candidates[1]] > 2 ? (d_candidates[2], d_candidates[1]) : (d_candidates[1], d_candidates[2])

    num_six = filter(x->mapping['e'] in x, sixletter_words)[1]
    mapping['c'] = setdiff("abcdefg", num_six)[1]
    mapping['a'] = filter(x->x != mapping['c'], collect(keys(c))[values(c) .== 8])[1]
    #println(setdiff("abcdefg", keys(mapping)))
    println(length(mapping))

    println(sort(mapping))
    Dict(v=>k for (k,v) in mapping)
end

function part2(data::Array)
    total = 0
    for (seq, out) in data
        mapping = buildmap(seq)
        mappedtext = join.(sort.(collect.(map.(x->get(mapping, x, x), split(out, " ")))))
        digits = []
        println(sort(mapping))
        println(seq)
        println(out)
        for t in mappedtext
            println(t)
            push!(digits, stoi(t))
        end
        println(digits)
        total += parse(Int, join(digits))
    end
    total
end


println(part2(data))