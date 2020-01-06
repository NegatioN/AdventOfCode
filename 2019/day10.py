from common import get_input
from copy import deepcopy
from math import acos, sqrt, degrees

data = get_input(day=10)

class Point:
    def __init__(self, x, y):
        self.x, self.y = x, y

    def vec_to_point(self, other):
        return Point(other.x - self.x, other.y - self.y)
    
    def __add__(self, other):
        return Point(self.x+other.x, self.y+other.y)

    def __mul__(self, other):
        if isinstance(other, Point):
            pass
        return Point(self.x*other, self.y*other)
    
    def __repr__(self):
        return f'({self.x}, {self.y})'

    def size(self):
        return sqrt(self.x ** 2 + self.y ** 2)

    def __hash__(self):
        return hash(str(self.size()) + str(self.x) + str(self.y))
    
    def __eq__(self, other):
        if isinstance(other, Point):
            return self.x == other.x and self.y == other.y
        else:
            return False

    def dot(self, other):
        return self.x*other.x + self.y*other.y
    
    def angle(self, other):
        p2 = (self.size() * other.size())
        p1 = self.dot(other)
        cos_v = self.dot(other) / (self.size() * other.size())
        print(self, other, p1, p2, cos_v)
        cos_v = 1 if cos_v > 1 else cos_v
        cos_v = -1 if cos_v < -1 else cos_v
        return degrees(acos(cos_v))

    def unit(self):
        def f(x):
            if x > 0:
                return 1
            elif x < 0:
                return -1
            else:
                return 0
        return Point(f(self.x), f(self.y))


def parse_pos(data):
    coords = []
    for y, line in enumerate(data):
        for x, point in enumerate(line):
            if point == '#':
                coords.append(Point(x,y))
    
    return coords

def calc_obscured(point, others, app_degrees, n=100):
    vecs = []
    visible = set(deepcopy(others))
    for p in others:
        vecs.append(point.vec_to_point(p))

    vecs = sorted(vecs, key=lambda x: x.size())
    for v in vecs:
        angle = round(point.angle(v))
        if angle not in app_degrees:
            obz = {point + (v * i) for i in range(2, n)}
        else:
            print(angle, v.unit(), v)
            obz = {point + v + (v.unit() * i) for i in range(1, n)}

        visible = visible.difference(obz)
    
    return len(visible)


points = parse_pos(data)

straight_angles = list(range(0,361, 45))
approved_degrees = list(filter(lambda x: x >= 0 and x <= 360, 
                    [y for x in straight_angles for y in [i for i in range(x-2, x+3, 1)]]))

print(f'Points: {len(points)}')
dists = []
for i in range(len(points)):
    tmp = deepcopy(points)
    tar = tmp.pop(i)
    dists.append(calc_obscured(tar, tmp, approved_degrees))
    break


m = 0
c = 0
for i, d in enumerate(dists):
    if d > m:
        c = i
        m = d
        
print(dists)
print(max(dists))
print(points[c], dists[c])

