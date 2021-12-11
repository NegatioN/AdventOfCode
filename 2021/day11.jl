data = reduce(hcat, map(x->parse.(Int, [y for y in x]), readlines("data/day11")))

function makeSelection(target::CartesianIndex, highest::Int)
   i, j = Tuple(target)
   js, je = j > 1 ? j-1 : j, j < highest ? j+1 : j
   is, ie = i > 1 ? i-1 : i, i < highest ? i+1 : i
   coords = map(CartesianIndex, Base.Iterators.product(is:ie, js:je))
   coords
end
function simulate(inp::Matrix, steps::Int)
    s = 0
    data, highest = copy(inp), size(inp)[1]
    marked = zeros(size(data))
    for _ in 1:steps
        data .+= 1
        while any(>=(10), data)

            for c in findall(x->x>=10, data)
                data[makeSelection(c, highest)] .+= 1
                data[c] = -9999
            end
        end
        flashed = data .>= 10 .|| data .< 0
        s += sum(flashed)
        data[flashed] .= 0 # Reset flashed
        marked .= 0
    end
   s
end

println(simulate(data, 100))
#println(data[coords])
#Just let points pass over 9, reset at the end. check for 9's to decide flashing
#TODO remove center point of product
#coords[length(coords)÷2+1]÷