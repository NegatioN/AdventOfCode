function traverse(letters::String, target::Char, high::Float64)
   nextPos = floor(high / 2)
   low::Float64 = 0
   for r in letters
       if r == target
           high = nextPos
       else
           low = nextPos + 1
       end
       nextPos = floor((high + low) / 2)
   end
   nextPos
end

highest = 0
for l in readlines("../data/day5")
   row = traverse(l[1:8], 'F', 127.0)
   seat = traverse(l[8:end], 'L', 7.0)
   seatNum = (row * 8) + seat
   global highest = seatNum > highest ? seatNum : highest
end
println(highest)