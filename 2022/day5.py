from copy import deepcopy
with open('data/day5', 'r') as f:
    stacks, instructions, = f.read().split('\n\n')
moves = []
for line in map(lambda x: x.split(), instructions.strip().split('\n')):
    num, fro, to = list(map(int, [line[1], line[3], line[5]]))
    moves.append((num, fro-1, to-1))

arrs = []
for x in zip(*stacks.split('\n')):
    try:
        int(x[-1]) # parse all lines with a number at the end
        arrs.append(list(filter(lambda x: x != ' ', x[::-1][1:])))
    except:
        pass

def compute(arrs, moves, f):
    arrs = deepcopy(arrs)
    for num, fro, to in moves:
        f(arrs, num, fro, to)

    return ''.join([x[-1] for x in arrs])

def part1_f(arrs, num, fro, to):
    for _ in range(num):
        arrs[to].append(arrs[fro].pop())
def part2_f(arrs, num, fro, to): arrs[to].extend(arrs[fro][-num:]); arrs[fro] = arrs[fro][:-num]

print(compute(arrs, moves, part1_f))
print(compute(arrs, moves, part2_f))
