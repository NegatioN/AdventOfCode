def m(x):
    d, dist = x.split()
    dist = -int(dist) if d in ['L', 'D'] else int(dist)
    return 'x' if d in ['R', 'L'] else 'y', dist
with open('data/day9', 'r') as f:
    data = list(map(m, f.read().splitlines()))

tx, ty = 0,0
x, y = 0,0
moves = set()

for d, dist in data:
    step = 1 if dist > 0 else -1
    for _ in range(abs(dist)):
        globals()[d] += step # move head
        # move tail if head is more than 1 step away from body in any direction
        if abs(tx - x) > 1:
            tx += 1 if tx < x else -1
            ty = y # jump to same y as head for diagonal moves
        if abs(ty - y) > 1:
            ty += 1 if ty < y else -1
            tx = x
        moves.add((tx, ty))

print(len(moves))
