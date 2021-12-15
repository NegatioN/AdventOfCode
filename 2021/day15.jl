data = reduce(hcat, map(x->parse.(Int32, [y for y in x]), readlines("data/day15test")))
println(data)
gcost = zeros(Int32, size(data))
for ((i, j), (ic, jc)) in zip(Base.Iterators.product(1:10, 1:10), Base.Iterators.product(9:-1:0, 9:-1:0))
    gcost[i, j] = ic+jc
end

candidates = [CartesianIndex(1, 1)]
camefrom = Dict{CartesianIndex, CartesianIndex}()
gscore = Dict{CartesianIndex}
while !isempty(candidates)
    c = pop!(candidates) #Todo, pick the cheapest node of the candidates. fscore
    if c == CartesianIndex(size(data))
        println("Winner")
    end

    for c.neighbour()
    end
    println(gcost[c], ",", data[c])
end
