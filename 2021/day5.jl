mat = zeros(Int8, (1000, 1000))
for l in readlines("data/day5")
   p1, p2 = map(z->split(z, ","), split(l, " -> "))
   (x1, y1), (x2, y2) = [parse(Int, x) for x in p1], [parse(Int, x) for x in p2]
   xstep, ystep = x1 > x2 ? -1 : 1, y1 > y2 ? -1 : 1
   if x1 == x2 || y1 == y2
       for i in x1:xstep:x2
           for j in y1:ystep:y2
                mat[j+1, i+1] += 1
           end
       end
   else
       for (i, j) in zip(x1:xstep:x2, y1:ystep:y2)
            mat[j+1, i+1] += 1
       end
   end
end
println(sum(mat .>1))