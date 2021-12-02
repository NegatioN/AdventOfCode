textlines = readlines("../data/day1")
ns = map(x->parse(Int64,x), textlines)

function part1(ns::Array, target::Int64)
    for n in ns
        for i in ns
            if i + n == target
                return i * n
            end
        end
    end
end

function part2(ns::Array, target::Int64)
    for n in ns
        for i in ns
            for j in ns
                if i + j + n == target
                    return j * i * n
                end
            end
        end
    end
end
println(part1(ns, 2020))
println(part2(ns, 2020))
