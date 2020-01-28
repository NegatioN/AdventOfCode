import os
from common import load_data, get_input
from copy import deepcopy
from functools import partial

a = get_input(6)

class DataNode:
    def __init__(self, data, parents=[]):
        self.data = data
        self.c = []
        self.p = parents
    
    def __repr__(self):
        return f'{self.data}'
    
    def parents(self):
        return self.p
    
    def add_child(self, x):
        new_node = DataNode(x, self.p + [self])
        self.c.append(new_node)
        return new_node

from collections import defaultdict
d = defaultdict(lambda: [])
for x in a:
    par, child = x.split(')')
    d[par].append(child)

root = DataNode('COM')
tar_nodes = [root]
seen = ['COM']
seen_n = [root]

while len(tar_nodes) > 0:
    tar = tar_nodes.pop()
    for orb in d[tar.data]:
        n = tar.add_child(orb)
        if orb not in seen:
            seen.append(orb)
            tar_nodes.append(n)
            seen_n.append(n)

print(sum([len(x.p) for x in seen_n]))

def get_node(arr, name):
    for x in arr:
        if x.data == name:
            return x

san = get_node(seen_n, 'SAN')
me = get_node(seen_n, 'YOU')

c = 0
for x, y in zip(san.p, me.p):
    if x == y:
        c += 1

print(me.p)
print(san.p)
print(len(me.p[c:]) + len(san.p[c:]))

#breakpoint()


