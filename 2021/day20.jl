function stupidpad(x, f, padsize=1)
    r = f(Int, size(x).+2*padsize)
    r[padsize+1:end-padsize, padsize+1:end-padsize] = x
    r
end
matbin2dec(x) = parse(Int, join(x), base=2)
function enhance(image, missing_val) algo[matbin2dec.(map.(x->x ∈ all_inds ? image[x] : missing_val, selections)).+1] end
function execute(image, num)
    for i in repeat([0,1], num÷2)
        image = enhance(image, i)
    end
    sum(image)
end

f = open("data/day20")
const algo = map(x->x=='#' ? 1 : 0, collect(readline(f)))
readline(f)

image = stupidpad(mapreduce(x->map(y->y=='#' ? 1 : 0,collect(x)), hcat, readlines(f)), zeros, 51)
const all_inds = CartesianIndices(image)
const selections = [CartesianIndices((-1:1, -1:1)) .+ x for x in all_inds]
println(execute(image, 50))
