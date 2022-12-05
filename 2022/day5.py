from copy import deepcopy

with open('data/day5', 'r') as f:
    stacks, instructions, = f.read().split('\n\n')

arrs = []
for x in zip(*stacks.split('\n')):
    try:
        int(x[-1])
        arrs.append(list(filter(lambda x: x != ' ', x[::-1][1:])))
    except:
        pass


def part1(arrs):
    arrs = deepcopy(arrs)
    for line in map(lambda x: x.split(), instructions.strip().split('\n')):
        num, fro, to = list(map(int, [line[1], line[3], line[5]]))
        for _ in range(num):
            arrs[to-1].append(arrs[fro-1].pop())
    return ''.join([x[-1] for x in arrs])

def part2(arrs):
    arrs = deepcopy(arrs)
    for line in map(lambda x: x.split(), instructions.strip().split('\n')):
        num, fro, to = list(map(int, [line[1], line[3], line[5]]))
        arrs[to-1].extend(arrs[fro-1][-num:])
        arrs[fro-1] = arrs[fro-1][:-num]

    return ''.join([x[-1] for x in arrs])

print(part1(arrs))
print(part2(arrs))
