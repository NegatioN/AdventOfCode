fish = map(x->[parse(Int, x), 6], split.(readlines("data/day6")[1], ","))

function calculateSpawn(fish::Array, i::Int)
    bins = zeros(Int64, 9)
    for j in fish bins[j[1]+1] += 1; end
    for _ in 1:i
        spawn = bins[1]
        bins[1:end-1], bins[end] = bins[2:end], spawn
        bins[7] += spawn
    end
    sum(bins)
end

println(calculateSpawn(fish, 80))
println(calculateSpawn(fish, 256))
