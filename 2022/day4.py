with open('data/day4', 'r') as f:
    data = [[map(int, y.split('-')) for y in x.strip().split(',')] for x in f.readlines()]

def toset(x): return set(range(x[0], x[1]+1))
def compute(data, condition_f): return sum(map(lambda x: condition_f(*map(toset,x)), data))

print(compute(data, lambda x,y: len(x & y) == len(x) or len(x & y) == len(y))) # Part1
print(compute(data, lambda x, y: len(x & y) > 0)) # Part2
