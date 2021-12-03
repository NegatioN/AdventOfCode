textlines = readlines("data/day3")

rows, cols = length(textlines), length(textlines[1])
mat = zeros(Int8, rows, cols)
for (i, l) in enumerate(textlines)
    for (j, c) in enumerate(l)
        mat[i, j] = parse(Int8, c)
    end
end

function arrayToBinary(arr)
    parse(Int, join(convert(Array{Int64}, arr)); base=2)
end

function part1(mat::Matrix)
    γ = sum(mat, dims=1) .> (size(mat)[1]/ 2)
    ε = γ .== 0
    arrayToBinary(γ) * arrayToBinary(ε)
end

function part2(mat::Matrix, comp::Function)
    rows, cols = size(mat)
    for i in 1:cols
        col = mat[:, i]
        if length(col) == 1; return mat; end
        inds = comp(sum(col), (length(col) / 2)) ? col.== 1 : col .== 0
        mat = mat[inds, :]
    end
    mat
end
a = arrayToBinary(part2(mat, <))
b = arrayToBinary(part2(mat, >=))
println(a * b)