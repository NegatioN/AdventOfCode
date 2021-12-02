filepath = "../data/day3"

treehits = 0
x = 0
for l in readlines(filepath)
    mapLine = Int64[x == '#' ? 1 : 0 for x in l]
    global treehits += mapLine[(x % length(mapLine)) + 1]
    global x += 3
end

println(treehits)

