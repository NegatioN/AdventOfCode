import os
from common import load_data, get_input
from copy import deepcopy
from functools import partial

a = get_input(5).split('\n')

class DataNode:
    def __init__(self, data, parents=[]):
        self.data = data
        self.c = []
        self.p = parents
    
    def children(self):
        return [y for x in self.c for y in x.children()]
    
    def parents(self):
        return self.p
    
    def add_child(self, x):
        self.c.append(x)

from collections import defaultdict
d = defaultdict(lambda: [])
for x in a:
    par, child = x.split(')')
    d[par].append(child)

tar_nodes = ['COM']



