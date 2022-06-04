using Test

function pair_levels(data, count::Int=0)
    a = first(data) isa Number ? count : pair_levels(first(data), count+1)
    b = last(data) isa Number ? count : pair_levels(last(data), count+1)
    vcat(a, b)
end
@test pair_levels([[[[3, 4], 3], 1], 5]) == [3,3,2,1,0]
@test pair_levels([[[[3,0],[5,3]],[4,4]],[5,5]]) == [3,3,3,3,2,2,1,1]
function collect_pairs(data)
    a = first(data) isa Number ? first(data) : collect_pairs(first(data))
    b = last(data) isa Number ? last(data) : collect_pairs(last(data))
    vcat(a, b)
end

function splitnum(val::Int, level::Int) return [floor(Int, val/2), level+1], [ceil(Int, val/2), level+1] end
@test splitnum(15, 3) == ([7, 4], [8, 4])

function execute(data)
    vallvls = []
    for j in 1:length(data)
        vallvls = vcat(vallvls, data[j])
        if j > 1 vallvls = [[x, y+1] for (x,y) in vallvls] end
        @label try_explode
        ended = true
        maxind, i = length(vallvls), 1
        while i < maxind
           al,bl = vallvls[i][2], vallvls[i+1][2]
           av,bv = vallvls[i][1], vallvls[i+1][1]
           if al >= 4 && bl >= 4 # Explode
               if i > 1 vallvls[i-1][1] += av end
               if i < length(vallvls)-1 vallvls[i+2][1] += bv end
               insert!(vallvls, i, [0, al-1])
               deleteat!(vallvls, i+1:i+2)
               maxind -= 1
               ended = false
           end
           i += 1
        end
        for i in 1:length(vallvls)
            val, lvl = vallvls[i][1], vallvls[i][2]
            if val > 9
               aa, ab = splitnum(val, lvl)
               deleteat!(vallvls, i)
               insert!(vallvls, i, aa)
               insert!(vallvls, i+1, ab)
               @goto try_explode
            end
        end
        if !ended @goto try_explode end
        #vallvls = [[x, y+1] for (x,y) in vcat(vallvls, data[j-1])]
    end
    vallvls
end

function structure_data(data) return [[x, y] for (x,y) in zip(collect_pairs(data), pair_levels(data))] end
@test map(last, structure_data([[[[3,0],[5,3]],[4,4]],[5,5]])) == [3,3,3,3,2,2,1,1]
texecute(d) = map(first, execute(map(structure_data, d)))
@test texecute([[[[1,1],[2,2]],[3,3]],[4,4]]) == [1,1,2,2,3,3,4,4]
@test texecute([[7,[6,[5,[4,[3,2]]]]]]) == [7,6,5,7,0]
@test texecute([[[6,[5,[4,[3,2]]]],1]]) == [6,5,7,0,3]
@test texecute([[[[[4,3],4],4],[7,[[8,4],9]]], [1,1]]) == [0,7,4,7,8,6,0,8,1]

testdata = [[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]],
[7,[[[3,7],[4,3]],[[6,3],[8,8]]]],
[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]],
[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]],
[7,[5,[[3,8],[1,4]]]],
[[2,[2,2]],[8,[8,1]]],
[2,9],
[1,[[[9,3],9],[[9,0],[0,7]]]],
[[[5,[7,4]],7],1],
[[[[4,2],2],6],[8,7]]]

@test texecute(testdata) == [8,7,7,7,8,6,7,7,0,7,6,6,8,7]

realdata = [[5,[7,[8,4]]],
[[[4,1],[6,[9,3]]],[[7,4],[5,[7,0]]]],
[[6,2],[[[8,6],[5,5]],0]],
[[[5,9],[3,[4,2]]],[[[1,2],0],2]],
[[[[4,3],2],0],[[[1,7],[1,2]],[[8,2],[6,7]]]],
[[[[0,1],9],3],[[4,7],[7,8]]],
[[[[8,7],4],[5,[9,2]]],[[8,[9,6]],[1,8]]],
[[[2,3],[[9,9],[7,0]]],[6,7]],
[8,[[9,9],[8,6]]],
[[[[5,7],[7,1]],[3,[7,6]]],[2,[[5,5],[8,3]]]],
[[[7,0],2],[[[2,2],7],[6,[2,9]]]],
[[6,2],[[0,8],8]],
[[[[2,9],4],9],[1,[[6,9],[7,5]]]],
[[[9,3],[[5,7],[3,1]]],[5,[6,[7,8]]]],
[0,[[8,9],1]],
[[4,[[4,3],4]],[7,[[4,0],0]]],
[[0,[[1,9],[6,1]]],[[[7,0],[5,2]],[[3,8],[0,4]]]],
[[[2,7],[7,[1,6]]],[6,[[8,7],[8,5]]]],
[[9,5],[[1,[2,5]],[8,[2,0]]]],
[6,[[8,[9,4]],[9,8]]],
[[[[2,0],[4,6]],3],[[8,0],4]],
[[[8,8],[[5,7],[5,6]]],5],
[[5,[[7,9],9]],[1,6]],
[[[[5,2],[4,9]],[[1,9],[2,9]]],[[[6,8],[7,5]],[[0,2],4]]],
[1,[5,[[5,5],[1,2]]]],
[[[1,4],[[0,3],7]],[[[9,1],9],[[2,3],7]]],
[[[[6,4],[4,0]],[[3,4],[7,0]]],[[8,7],[5,[0,6]]]],
[[3,[8,[2,8]]],[9,[0,[5,2]]]],
[[7,[[1,8],1]],[6,[6,6]]],
[[[3,[9,4]],[[3,2],[5,2]]],8],
[3,[[4,[4,3]],[5,[9,2]]]],
[[[1,8],[2,[7,5]]],[[0,[8,1]],[2,0]]],
[1,3],
[7,[[[9,6],[8,4]],9]],
[6,4],
[[[8,9],[[3,7],2]],[4,[[5,0],8]]],
[[[[1,8],[7,9]],0],[[[4,4],3],[4,[1,7]]]],
[[[[2,2],[0,9]],[1,2]],[[[9,1],[0,0]],[[1,6],4]]],
[[[[8,1],6],[[3,3],[6,7]]],[[2,3],5]],
[[[[9,0],7],6],[[[3,6],[6,7]],3]],
[[[[1,0],6],[5,[0,0]]],[[[9,7],7],5]],
[[[[5,1],4],[[7,7],[6,2]]],[[0,[6,0]],2]],
[[[[8,3],[0,4]],[[9,9],[3,7]]],[[[2,7],[2,9]],[[2,0],[4,7]]]],
[6,[[[4,8],0],8]],
[[[6,[5,9]],[[0,3],9]],[[[2,5],[9,5]],0]],
[[1,4],[6,[0,[6,2]]]],
[9,[[[3,7],1],7]],
[[[2,3],[[1,2],1]],[[[2,6],[0,1]],[0,[4,1]]]],
[[[0,1],[[0,3],[7,3]]],[[8,7],3]],
[[0,[[1,5],[5,3]]],4],
[[[5,3],[[5,8],6]],[[[6,0],3],[4,1]]],
[8,3],
[[[[5,5],[3,0]],6],[[7,5],[2,[9,4]]]],
[[[3,[3,3]],[[4,7],4]],[[2,0],1]],
[[[0,[2,8]],[4,[7,9]]],[[[5,4],2],2]],
[[3,[7,[1,8]]],[5,[[8,2],0]]],
[[1,9],[[6,[5,9]],8]],
[[5,[5,2]],5],
[[[1,1],[4,3]],1],
[[[[6,9],[4,1]],0],[[[3,0],6],7]],
[[9,[[7,3],6]],[[[7,2],0],[9,9]]],
[[5,4],[[[6,0],[5,1]],7]],
[[[4,0],0],[[[2,6],[4,4]],[[6,8],2]]],
[[[9,6],8],[[0,[9,5]],9]],
[[6,[2,5]],[[[1,8],[9,0]],[[4,0],[5,7]]]],
[5,[[8,[9,9]],[5,[6,8]]]],
[[[7,[9,0]],5],6],
[[9,[[3,7],[3,0]]],[[[7,2],[5,7]],[[0,5],[7,4]]]],
[[7,3],[[6,5],[9,4]]],
[[4,[4,3]],[9,[[2,6],0]]],
[[[6,[0,1]],9],[[7,[3,2]],[[0,1],[5,2]]]],
[[5,[0,[3,1]]],[[[1,1],[8,9]],[[6,3],[0,9]]]],
[[[[2,8],0],[[8,7],4]],[[[9,6],3],[[7,8],[2,3]]]],
[[[[1,0],1],4],[4,9]],
[[[7,8],5],[[[3,7],[5,7]],6]],
[[[8,[7,4]],[[1,6],[6,7]]],[2,4]],
[[7,8],3],
[[0,[4,[3,8]]],[[[1,0],1],6]],
[[[[6,3],7],2],[[4,5],6]],
[[[5,9],[[1,8],1]],[[[1,8],8],[[6,4],0]]],
[[3,[8,[2,8]]],[[[2,8],[4,4]],9]],
[7,[5,[[3,3],3]]],
[3,[1,[0,[3,0]]]],
[[[1,2],4],[9,[[7,1],[5,4]]]],
[[[5,8],[7,[0,7]]],[0,[[2,9],8]]],
[[[7,[2,0]],[1,[4,3]]],[0,[[1,1],[2,0]]]],
[[[2,[2,5]],[4,1]],[0,[6,0]]],
[[[8,3],9],[[[4,3],[5,8]],[[7,0],9]]],
[2,[1,4]],
[[[3,[2,6]],6],[[[3,2],[0,8]],[[3,5],[6,4]]]],
[[[1,[3,3]],[[0,8],[1,3]]],[8,[[3,8],[0,8]]]],
[[[[1,5],[0,1]],3],[[6,[1,7]],[4,7]]],
[[4,[5,7]],[6,[[6,2],7]]],
[[[[7,4],[3,1]],[5,6]],[0,[6,5]]],
[[[7,[0,0]],6],[5,[[0,0],[3,5]]]],
[[[[8,7],[5,8]],[8,[9,3]]],[[7,0],[[7,2],0]]],
[[[7,[4,2]],0],[[[4,0],1],3]],
[[[6,3],[9,[2,2]]],[[0,8],[1,2]]],
[3,[[3,1],[[7,1],1]]],
[[3,[[4,0],7]],[[[4,6],[2,3]],[[0,2],[1,8]]]],
]

output = execute(map(structure_data, realdata))
#do fucking magnitudes by hand.