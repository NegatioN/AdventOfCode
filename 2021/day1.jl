textlines = readlines("data/day1")
depths = map(x->parse(Int64,x), textlines)


function part1(depths)
    comp = 0
    count = 0
    for d in depths
        if d > comp
           count += 1
        end
       comp = d
    end
    count - 1
end

println(part1(depths))

function part2(depths)
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