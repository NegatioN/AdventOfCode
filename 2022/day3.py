with open('data/day3', 'r') as f:
    data = f.read().strip().split('\n')

def overlap_char(sets): return set.intersection(*sets).pop()
def score_func(c): return ord(c) - 38 if c.upper() == c else ord(c) - 96
def split_equal(s): return set(s[:len(s)/2]), set(s[len(s)/2:])

print(sum(map(score_func, map(overlap_char, map(split_equal, data)))))
def split_groups(data): return [[set(s) for s in data[i:i+3]] for i in range(0, len(data), 3)]
print(sum(map(score_func, map(overlap_char, split_groups(data)))))
