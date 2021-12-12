data = reduce(hcat, map(x->parse.(Int32, [y for y in x]), readlines("data/day11")))

function makeSelection(target::CartesianIndex, cm::CartesianIndices)
   i, j = Tuple(target)
   filter(x->x ∈ cm, map(CartesianIndex, Base.Iterators.product(i-1:+1, j-1:j+1)))
end
function simulate(inp::Matrix, steps::Int)
    s = 0
    data, cm = copy(inp), CartesianIndices(inp)
    for i in 1:steps
        data .+= 1
        while any(>=(10), data)
            for c in findall(x->x>=10, data)
                data[makeSelection(c, cm)] .+= 1
                data[c] = -9999
            end
        end
        flashed = data .>= 10 .|| data .< 0
        s += sum(flashed)
        data[flashed] .= 0 # Reset flashed
        if sum(data) == 0 # Part 2
            return i
        end
    end
   s # Part1
end

println(simulate(data, 1000))
