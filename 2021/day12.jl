using StatsBase
struct Node
    label::String
    large::Bool
    edges::Array{Node}
end

nodes = Dict{String, Node}()
for (p, t) in split.(readlines("data/day12"), "-")
   if t ∉ keys(nodes) nodes[t] = Node(t, t!=lowercase(t), []) end
   if p ∉ keys(nodes) nodes[p] = Node(p, p!=lowercase(p), []) end
   push!(nodes[p].edges, nodes[t])
   push!(nodes[t].edges, nodes[p])
end

function traverse(n::Node, explored::Vector{Node}, all_paths::Vector{Vector{Node}}, cond::Function)
    if n.label == "end" push!(all_paths, explored); return end
    push!(explored, n)
    for c in setdiff(n.edges, filter(x->cond(x, explored), explored))
        traverse(c, copy(explored), all_paths, cond)
    end
    return all_paths
end
part1(x, c) = !x.large
part2(x, c) = !x.large && maximum(values(countmap(filter(y->!y.large,  c)))) > 1
res = traverse(nodes["start"], Vector{Node}(), Vector{Vector{Node}}(), part2)
println(length(res))
println(sum(filter(y->y<2, count.(x->x.label=="start", res)))) # Exclude paths which use "start"-node twice.