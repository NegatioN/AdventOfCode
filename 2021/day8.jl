using StatsBase

data = split.(readlines("data/day8test"), " | ")
function part1(data::Array, targets=[2 3 4 7])
    c = 0
    for (_, out) in data
        c += sum(indexin(length.(split(out, " ")), targets) .!= nothing)
    end
    c
end
println(part1(data))


function buildmap(seq)
    km = Dict()
    for s in sort(split(seq, " "), by=length)
        ss = sort(collect(s))
        println(ss)
        if length(ss) == 2
            km['c'], km['g'] = ss
        elseif length(ss) == 3
            km['c'], km['b'], km['g'] = ss
        elseif length(ss) == 4
            km['b'], km['c'], km['d'], km['f'] = ss
        #elseif length(ss) == 7
        #    km['a'], km['b'], km['c'], km['d'], km['e'], km['f'], km['g'] = ss
        end
        println(km)
    end
    km
end

function part2(data::Array)
    for (seq, out) in data
        #todo map all easy values directly to a number.
        #todo make func to decide the hard cases (5count?)
        # 0, 6, 9 = 6 count
        # 2, 3, 5 = 5 count

        mapping = buildmap(seq)
        mappedtext = map(x->get(mapping, x, x), out)
        println(mappedtext)
        counts = countmap.(split(mappedtext, " "))
        digits = []
        for (e, n) in zip(counts, length.(counts))
            if n == 5
               if haskey(e, 'g')
                   push!(digits, 2)
               elseif haskey(e, 'e')
                   push!(digits, 5)
               else
                   push!(digits, 3)
               end
            elseif n == 6
               if !haskey(e, 'g')
                   push!(digits, 9)
               elseif !haskey(e, 'f')
                   push!(digits, 0)
               else
                   push!(digits, 6)
               end
            elseif n == 2
               push!(digits, 1)
           elseif n == 3
               push!(digits, 7)
           elseif n == 4
               push!(digits, 4)
           elseif n == 7
               push!(digits, 8)
            end
        end
        println(out)
        println(digits)
    end
end

println(part2(data))