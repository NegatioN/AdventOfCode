import os
from common import get_input
from copy import deepcopy
from functools import partial
from inspect import getsource

data = [int(x) for x in get_input(day=9)[0].split(',')]
pad = lambda a, n: ([0] * (n-len(a))) + a

valid_opcodes = [1,2,3,4,5,6,7,8,9]

functions = {1: {'f': lambda x, y: x + y, 'n': 2},
             2: {'f': lambda x, y: x * y, 'n': 2},
             3: {'f': lambda: 2, 'n': 0},
             4: {'f': lambda x: print(x), 'n': 1},
             5: {'f': lambda x, y: x != 0, 'n': 2},
             6: {'f': lambda x, y: x == 0, 'n': 2},
             7: {'f': lambda x, y: int(x < y), 'n': 2},
             8: {'f': lambda x, y: int(x == y), 'n': 2},
             9: {'f': lambda x: x, 'n': 1}
             }

class Computer:
    def __init__(self, mem, functions, phase=None, i=0, rel_phase=0, extended_mem=10000, debug=False):
        self.phase, self.i, self.rel_base, self.debug = phase, i, rel_phase, debug
        self.pdebug('Orig. Mem Size', len(mem))
        self.mem = deepcopy(mem) + [0 for i in range(extended_mem)]
        self.fs = deepcopy(functions)

    def mem_get(self, m, i):
        if m == 0:
            return self.mem[i]
        elif m == 1:
            return i
        elif m == 2:
            return self.mem[i + self.rel_base]

    def mem_set(self, m, i):
        if m == 0 or m == 1:
            return i
        if m == 2:
            return i + self.rel_base
    
    def pdebug(self, text, val):
        if self.debug:
            print(f'{text}: {val}')

    def op_action(self):
        num = pad([int(x) for x in str(self.mem[self.i])], 5)
        self.pdebug('op str', num)
        act = (num[-2] * 10) + num[-1]
        self.pdebug('op', act)
        return act
    
    def op_modes(self):
        nums = pad([int(x) for x in list(str(self.mem[self.i]))], 5)
        v = list(reversed(nums[:3]))
        self.pdebug('op modes', v)
        return v

    def prepare_op(self, n):
        return self.fs[n]['f'], self.fs[n]['n']

    def update_rel_base(self, res):
        if res:
            self.rel_base += res

    def execute(self):
        op_action = self.op_action()
        if not op_action in valid_opcodes:
            raise Exception(f'Halting, erronous opcode: {op_action}')

        op_modes = self.op_modes()
        self.i += 1
        op, num_params = self.prepare_op(op_action)
        param_modes = [op_modes.pop(0) for i in range(num_params)]
        params = self.mem[self.i:self.i+num_params] # noun_p, verb_p or noun_p
        self.i += num_params

        self.pdebug('params', params)
        self.pdebug('param_modes', param_modes)
        values = [self.mem_get(val_m, val_p) for val_p, val_m in zip(params, param_modes)]
        res = op(*values)
        if res != None:
            if op_action in [5,6]: # special case pointer manip
                if res:
                    self.i = values[1]
            elif op_action == 9:
                self.rel_base += res
            else:
                self.store(op_modes.pop(0), res)

        if self.debug:
            print('values:', op_action, values)
            print('Current i:', self.i, 'current rel_p:', self.rel_base)
            print('Res:', res)
            print('------------')

        
    def store(self, out_m, res):
        pos = self.mem_set(out_m, self.mem[self.i])
        self.mem[pos] = res
        self.i+= 1
        self.pdebug('out_p', pos)
        self.pdebug('out_m', out_m)


comp = Computer(data, functions, debug=False)

while comp.i < len(comp.mem):
    comp.execute()
