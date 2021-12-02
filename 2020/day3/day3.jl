filepath = "../data/day3"

function checkHits(xStep::Int, yStep::Int, textlines::Array)
    treehits, x = 0, 0
    for l in textlines[1:yStep:end]
        mapLine = Int64[x == '#' ? 1 : 0 for x in l]
        treehits += mapLine[(x % length(mapLine)) + 1]
        x += xStep
    end
    treehits
end
textlines = readlines(filepath)
p1 = checkHits(3, 1, textlines)
p2 = 1
for (x, y) in zip([1, 3, 5, 7, 1], [1,1,1,1,2])
   global p2 *= checkHits(x, y, textlines)
end
println(p1)
println(p2)
