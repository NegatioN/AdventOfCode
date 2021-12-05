function overlappingPoints(textlines::Array, mat::Matrix, diagonalfunc::Function)
   for l in textlines
       (x1, y1, x2, y2) = map(x->parse.(Int,x)+1, split.(replace(l, " -> " => ","), ","))
       xstep, ystep = x1 > x2 ? -1 : 1, y1 > y2 ? -1 : 1
       f(x, y) = x1 == x2 || y1 == y2 ? collect(Base.Iterators.product(x, y)) : diagonalfunc(x, y)
       for (i, j) in f(x1:xstep:x2, y1:ystep:y2)
            mat[j, i] += 1
       end
   end
   sum(mat .> 1)
end

textlines = readlines("data/day5")
empty(x...) = zip([], x...)
println(overlappingPoints(textlines, zeros(Int8, (1000, 1000)), empty)) #part1
println(overlappingPoints(textlines, zeros(Int8, (1000, 1000)), zip)) #part2
