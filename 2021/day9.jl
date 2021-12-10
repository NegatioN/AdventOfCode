data = map(x->"9"*x*"9", readlines("data/day9"))
l = length(data[1])
insert!(data, 1, repeat("9", l))
insert!(data, length(data)+1, repeat("9", l))

data = [parse(Int8, x) for x in join(data)]
function findlowpoints(data::Array)
    lowpoints = []
    for i in 1:length(data)
       adj = filter(x->x>1&&x<length(data), [i-l, i-1, i+1, i+l])
       if all(>(data[i]), data[adj])
           push!(lowpoints, i)
       end
    end
    lowpoints
end
lowpoints = findlowpoints(data)
println(sum(data[lowpoints] .+ 1))

function findbasins(data::Array, lowpoints::Array)
    basins = []
    for lp in lowpoints
        basin = [lp]
        candidates = [lp]
        while !isempty(candidates)
            i = pop!(candidates)
            adj = filter(x->x>1&&x<length(data), [i-l, i-1, i+1, i+l])
            ncand = setdiff(adj[data[adj] .!= 9], basin)
            append!(candidates, ncand)
            append!(basin, ncand)
        end
        append!(basins, length(basin))
    end
    r = sort(basins, rev=true)[1:3]
    r[1] * r[2] * r[3]
end

println(findbasins(data, lowpoints))