input = readlines("data/day13")
folds = split.(replace.(filter(x->occursin("fold along", x), input), "fold along "=>""), "=")
dots = reverse.(map(x->parse.(Int, x).+1, split.(filter(x->!occursin("fold along", x), input), ",")))
function fold(dots::Array, folds::Array)
    m = Tuple(maximum(reduce(hcat, dots), dims=2))
    mat = zeros(Int8, m)
    mat[map(CartesianIndex, map(Tuple, dots))] .= 1
    for (d, ss) in folds
        s = parse(Int, ss) + 1
        if d == "y"
            mat = mat[1:s-1, :] + mat[end:-1:s+1, :]
        else
            mat = mat[:, 1:s-1] + mat[:, end:-1:s+1]
        end
        println(count(x->x>=1, mat))
    end
    mat
end
res = fold(dots, folds)
display(res)