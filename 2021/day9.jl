data = readlines("data/day9")
l = length(data[1])
println(l)

lowpoints = []
d = [parse(Int8, x) for x in join(data)]
for i in 1:length(d)
   adj = filter(x->x>1&&x<length(d), [i-l, i-1, i+1, i+l])
   if sum(d[adj] .>= d[i]) == length(adj)
       push!(lowpoints, i)
   end
end
println(sum(d[lowpoints] .+ 1))