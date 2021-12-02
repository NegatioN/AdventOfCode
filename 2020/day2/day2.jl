filepath = "../data/day2"
total1 , total2 = 0, 0
for l in readlines(filepath)
    range, letter, pw = split(l, limit=3)
    low, high = map(x->parse(Int64, x), split(range, "-"))
    c = count(i->(i == letter[1]), pw)
    if (c <= high) & (c >= low)
        global total1 += 1
    end
    if (pw[low] == letter[1]) ⊻ (pw[high] == letter[1])
        global total2 += 1
    end
end
println(total1)
println(total2)
