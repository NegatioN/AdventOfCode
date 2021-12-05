function overlappingPoints(textlines::Array, mat::Matrix, diagonalfunc::Function)
   for l in textlines
       p1, p2 = map(z->split(z, ","), split(l, " -> "))
       (x1, y1), (x2, y2) = [parse(Int, x) for x in p1], [parse(Int, x) for x in p2]
       xstep, ystep = x1 > x2 ? -1 : 1, y1 > y2 ? -1 : 1
       f(x, y) = x1 == x2 || y1 == y2 ? collect(Base.Iterators.product(x, y)) : diagonalfunc(x, y)
       for (i, j) in f(x1:xstep:x2, y1:ystep:y2)
            mat[j+1, i+1] += 1
       end
   end
   sum(mat .> 1)
end

mat = zeros(Int8, (1000, 1000))
textlines = readlines("data/day5")
empty(x...) = zip([], x...)
println(overlappingPoints(textlines, mat, empty)) #part1
println(overlappingPoints(textlines, mat, zip)) #part2
