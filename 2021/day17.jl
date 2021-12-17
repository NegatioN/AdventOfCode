# No parsing, just input manually
function shoot(xspeed::Int, yspeed::Int, maxx::Int, miny::Int, target::Matrix{Tuple{Int64, Int64}})
    pos = Tuple((0, 0))
    while pos[1] <= maxx && pos[2] >= miny
        pos = Tuple((pos[1] + xspeed, pos[2] + yspeed))
        if pos ∈ target return true end
        yspeed -= 1
        if xspeed > 0 xspeed -= 1
        elseif xspeed < 0 xspeed += 1
        end
    end
    false
end

const target = Tuple.(CartesianIndices((206:250, -105:-57)))
hits = []
for x = -250:250, y = -250:150
    if shoot(x, y, 250, -105, target) push!(hits, y) end
end

println(length(hits))
#maxyvel, ypos, posz = maximum(hits), 0, []
#println(maxyvel)
#for _ in 1:1000
#   global ypos += maxyvel
#   push!(posz, ypos)
#   global maxyvel -= 1
#end
#println(maximum(posz))