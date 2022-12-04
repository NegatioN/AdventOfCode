with open('data/day4', 'r') as f:
    data = [[map(int, y.split('-')) for y in x.strip().split(',')] for x in f.readlines()]

def toset(x): return set(range(x[0], x[1]+1))
def part1_condition(x, y): return len(x & y) == len(x) or len(x & y) == len(y)
def compute(data, condition_f):
    count = 0
    for x, y in data:
        if condition_f(toset(x), toset(y)):
            count += 1
    return count

print(compute(data, part1_condition)) # Part1
print(compute(data, lambda x, y: len(x & y) > 0)) # Part2
