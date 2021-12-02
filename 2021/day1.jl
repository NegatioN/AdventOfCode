textlines = readlines("data/day1")
depths = map(x->parse(Int64,x), textlines)


function part1(depths::Array)
    total = zero(eltype(depths))
    for i in 2:length(depths)
        if depths[i-1] < depths[i]
            total += 1
        end
    end
    total - 1
end

println(part1(depths))

function part2(depths::Array)
    count = 0
    comp = 0
    for i in 2:length(depths)- 1
        num = sum(depths[i-1:1:i+1])
        if num > comp
            count += 1
        end
        comp = num
    end
    count - 1
end

println(part2(depths))