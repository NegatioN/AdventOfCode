data = reduce(hcat, map(x->parse.(Int32, [y for y in x]), readlines("data/day15")))

function reconstruct_path(camefrom::Dict{CartesianIndex, CartesianIndex}, current::CartesianIndex)
    total_path = [current]
    while current ∈ keys(camefrom)
        current = camefrom[current]
        push!(total_path, current)
   end
   total_path
end

function astar(data::Matrix)
    start, goal, indices = CartesianIndex(1,1), CartesianIndex(size(data)), CartesianIndices(size(data))
    h(x) = sum(Tuple(goal) .- Tuple(x))
    candidates = [start]
    camefrom = Dict{CartesianIndex, CartesianIndex}()
    gscore, fscore = ones(Int32, size(data)) * 16000, ones(Int32, size(data)) * 16000
    gscore[start], fscore[start] = 0, h(start)

    while !isempty(candidates)
        _, ind = findmin(map(x->fscore[x], candidates))
        c = popat!(candidates, ind)
        if c == goal return reconstruct_path(camefrom, c) end

        for n in map(CartesianIndex, [(c[1]+1, c[2]), (c[1]-1, c[2]), (c[1], c[2]+1), (c[1], c[2]-2)])
            if n ∈ indices tentative_gscore = gscore[c] + data[n]
                if tentative_gscore < gscore[n]
                    camefrom[n] = c
                    gscore[n], fscore[n] = tentative_gscore, tentative_gscore + h(n)
                    if n ∉ candidates push!(candidates, n) end
                end
            end
        end
    end
end

function enlarge_map(data::Matrix)
    datas = [data]
    for i in 1:4 push!(datas, (datas[i].%9).+1) end
    datas = [hcat(datas...)]
    for i in 1:4 push!(datas, (datas[i].%9).+1) end
    vcat(datas...)
end

ldata = enlarge_map(data)
path = astar(ldata)
println(sum(ldata[path]) - ldata[1, 1])
