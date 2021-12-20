using Test

f = open("data/day20")
const algo = map(x->x=='#' ? 1 : 0, collect(readline(f)))
readline(f)

function stupidpad(x, f, padsize=1)
    r = f(Int, size(x).+2*padsize)
    r[padsize+1:end-padsize, padsize+1:end-padsize] = x
    r
end
image = stupidpad(mapreduce(x->map(y->y=='#' ? 1 : 0,collect(x)), hcat, readlines(f)), zeros, 55)

const all_inds = CartesianIndices(image)
rows(M) = (view(M, i, :) for i in 1:size(M, 1))
matbin2dec(x) = parse(Int, join(x), base=2)

const selection = CartesianIndices((-1:1, -1:1))
function enhance(image, missing_val)
    new_image = zeros(Int, size(image))
    for ind in all_inds
         index = matbin2dec(map(x->x ∈ all_inds ? image[x] : missing_val, selection .+ ind))
         new_image[ind] = algo[index+1]
    end
    new_image
end

its = 50
for i in repeat([0,1], its÷2)
    global image = enhance(image, i)
end
println(sum(image))