with open('data/day3', 'r') as f:
    data = f.read().strip().split('\n')

def overlap_char(data): return set.intersection(*map(set, data)).pop()
def score(c): return ord(c) - 38 if c.upper() == c else ord(c) - 96
def split_equal(s): return s[:len(s)/2], s[len(s)/2:]

print(sum(map(score, map(overlap_char, map(split_equal, data))))) # Part1

def split_groups(data): return [data[i:i+3] for i in range(0, len(data), 3)]
print(sum(map(score, map(overlap_char, split_groups(data))))) # Part2
