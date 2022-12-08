import numpy as np
from functools import partial
with open('data/day8', 'r') as f:
    data = np.array([[int(y) for y in x] for x in f.read().strip().splitlines()])

def compute(data, chunk_f, group_f):
    viewable = np.zeros_like(data)
    for i, j in [(i, j) for i in range(1, len(data)-1) for j in range(1, len(data)-1)]:
        up, down, left, right, = data[:j, i], np.flip(data[j+1:, i]), data[j, :i], np.flip(data[j, i+1:]) # need to do a counter-intuitive flip here to reflip in part2
        viewable[i, j] = group_f(*list(map(partial(chunk_f, data[j, i]), [up, down, left, right])))
    return viewable

viewable = compute(data, lambda target, chunk: (target > chunk).all(), lambda *x: np.any(x))
print(viewable.sum() + (4*len(data) - 4))  # part1, all found + edges

def look_in_chunk(target, chunk): # flips chunks, and sums up how far we can see in each direction
    x = np.minimum.accumulate(target > np.flip(chunk))
    return x.sum() if x.all() else x.sum() + 1 # if a tree blocks, that counts as "seeing" a tree too.

print(compute(data, look_in_chunk, lambda *x: np.prod(x)).max())  # Part 2