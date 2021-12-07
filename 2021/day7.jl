using Statistics
using Printf
data = map.(x->parse(Int, x), split.(readline("data/day7"), ","))

println(sum(abs.(data .- median(data))))
@printf "%f\n" sum(map(x->(x^2+x)/2, abs.(data .- floor(mean(data)))))