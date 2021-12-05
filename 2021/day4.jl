textlines = readlines("data/day4")

numbers = map(x->parse(Int, x),split(textlines[1], ','))
boardData = textlines[3:end]
boards = zeros(Int8, 5, 5, Int(ceil(length(boardData) / 6)))

for (i, l) in enumerate(boardData)
    if l != ""
        for (j, c) in enumerate(split(l))
            boards[i%6, j, Int(floor(i/6))+1] = parse(Int8, c)
        end
    end
end
#display(boards)

function scoreBoards(boards, numbers)
    boardHits = zeros(Int8, size(boards))
    boardsInPlay = 1:size(boards)[end]
    scoreboard = []
    for n in numbers
        boardHits[boards .== n] .= 1
        vertiHits, horizHits = sum(boardHits, dims=1), sum(boardHits, dims=2)
        removed = []
        for b in boardsInPlay
            if maximum(vertiHits[:, :, b]) >= 5 || maximum(horizHits[:,:,b]) >= 5
                push!(scoreboard, sum(boards[:,:,b][boardHits[:, :, b] .== 0]) * n)
                push!(removed, b)
            end
        end
        boardsInPlay = setdiff(boardsInPlay, removed)
    end
    scoreboard
end

scores = scoreBoards(boards, numbers)
println([scores[1], scores[end]])