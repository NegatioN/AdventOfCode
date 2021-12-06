jellies = map(x->[parse(Int, x), 6], split.(readlines("data/day6")[1], ","))

function calculateSpawn(jellies::Array, i::Int)
    gen1bins, bins = zeros(Int64, 9), zeros(Int64, 7)
    for j in jellies gen1bins[j[1]+1] += 1; end
    for _ in 1:i
        spawn = gen1bins[1] + bins[1]
        bins[1:end-1], gen1bins[1:end-1] = bins[2:end], gen1bins[2:end]
        bins[end], gen1bins[end] = spawn, spawn
    end
    sum(gen1bins) + sum(bins)
end

println(calculateSpawn(jellies, 80))
println(calculateSpawn(jellies, 256))
