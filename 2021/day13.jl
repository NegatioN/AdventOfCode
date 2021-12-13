input = readlines("data/day13")
folds = split.(replace.(filter(x->occursin("fold along", x), input), "fold along "=>""), "=")
dots = reverse.(map(x->parse.(Int, x), split.(filter(x->!occursin("fold along", x), input), ",")))

function foldpoints(dots::Array, folds::Array)
   current = Set(copy(dots))
   for (axis, ss) in folds
        s = parse(Int, ss)
       for p in current
            if axis == "y" && p[1] > s
               push!(current, [s-(p[1]-s), p[2]])
               pop!(current, p)
            end
            if axis == "x" && p[2] > s
               push!(current, [p[1], s-(p[2]-s)])
               pop!(current, p)
            end
       end
   end
   current
end

res = foldpoints(dots, folds)
println(res)
m = zeros(Int8, (8, 40))
for (x,y) in res
   m[x+1, y+1] = 1
end
display(m)