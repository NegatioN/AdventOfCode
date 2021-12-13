input = readlines("data/day13")
folds = split.(replace.(filter(x->occursin("fold along", x), input), "fold along "=>""), "=")
dots = reverse.(map(x->parse.(Int, x).+1, split.(filter(x->!occursin("fold along", x), input), ",")))

function fold(dots::Array, folds::Array)
    m = Tuple(maximum(reduce(hcat, dots), dims=2))
    mat = zeros(Int32, m)
    mat[map(CartesianIndex, map(Tuple, dots))] .= 1
    for (d, ss) in folds
        s = parse(Int, ss)
        sb, se = (s+2, s+s+1)
        println(s, " ", sb, " ", se)
        if d == "y"
            emat = mat[end:-1:sb, :]
            mat = mat[s-size(emat, 1)+1:s, :] + emat
        else
            emat = mat[:, end:-1:sb]
            mat = mat[:, s-size(emat, 2)+1:s] + emat
        end
        println(count(x->x>=1, mat))
    end
    mat
end
res = fold(dots, folds)
println(count(x->x>1, res))

println(map(x->x>=1 ? '#' : ' ', res))
display(res .>=1)
display(transpose(res .>1))