import os
from common import get_input
from copy import deepcopy
from functools import partial

data = get_input(day=7)

val_atpos = lambda a, x: a[x]
val = lambda a, x: x

def mode_interp(m):
    if m == 0:
        return val_atpos
    else:
        return val

pad = lambda a, n: ([0] * (n-len(a))) + a

def format_opcode(opcode, debug=False):
  op_ints = pad([int(x) for x in list(str(opcode))], 5) # prepend with 0s for modes
  if debug:
      print('Op:', op_ints)
  (noun_m, verb_m, out_m), op_action = op_ints[:3], (10 * op_ints[3] + op_ints[4])
  return (noun_m, verb_m, out_m), op_action

valid_opcodes = [1,2,3,4,5,6,7,8]

functions = {1: {'f': lambda x, y: x + y, 'n': 2},
             2: {'f': lambda x, y: x * y, 'n': 2},
             3: {'f': lambda: int(input("Please input a number: ")), 'n': 0},
             4: {'f': lambda x: x, 'n': 1},
             5: {'f': lambda x, y: x != 0, 'n': 2},
             6: {'f': lambda x, y: x == 0, 'n': 2},
             7: {'f': lambda x, y: int(x < y), 'n': 2},
             8: {'f': lambda x, y: int(x == y), 'n': 2},
             }

def execute(op_action, functions):
    f = functions[op_action]
    return f['f'], f['n']

def computer(a, inps, final_hook_f, i=0, debug=False):
  fs = deepcopy(functions)
  fs[3] = {'f': lambda: inps.pop(0), 'n': 0}
  while i < len(a):
    modes, op_action = format_opcode(a[i], debug=debug)
    if not op_action in valid_opcodes:
        raise Exception(f'Halting, erronous opcode: {op_action}')
    i += 1
    op, num_params = execute(op_action, fs)
    params = a[i:i+num_params] # noun_p, verb_p or noun_p

    i += num_params
    values = [mode_interp(val_m)(a, val_p) for val_p, val_m in zip(params, reversed(modes))]

    res = op(*values)
    if op_action == 4:
        return res, i
    if res != None:
        if op_action in [5,6]: # special case pointer manip
            if res:
                i = values[1]
        else:
            out_p = a[i] # out_p is always in position mode.
            i+= 1
            a[out_p] = res
    
    if debug:
      print('Modes:', modes)
      print('Params:', params)
      print('values:', op_action, values, out_p)
      print('Current i:', i)

  return final_hook_f(a), i

def amplify(phases, a):
    i = 0
    for x in phases:
        i = computer(deepcopy(a), inps=[x, i], final_hook_f=print)
    return i

def feedback_amp(phases, a):
    i = 0
    c = 0
    s = len(phases)
    amp_mems = [deepcopy(a) for i in range(s)]
    pointers = [0 for i in range(s)]
    while True:
        try:
            selector = c%s
            if c <= s:
                p_val = phases[selector]
                inps = [p_val, i]
            else:
                inps = [p_val, i]
            print(selector)
            mem, pointer = amp_mems[selector], pointers[selector]
            i, offset = computer(mem, inps=inps, final_hook_f=print, i=pointer, debug=False)
            print(i, offset)
            pointers[selector] = offset
        except:
            break
        c += 1
    return i



from itertools import permutations

a = [int(x) for x in data[0].split(',')]

res = feedback_amp([9,8,7,6,5], deepcopy(a))
print(res)
'''
max_thrust = 0
for x in permutations([9,8,7,6,5]):
    res = feedback_amp(x, deepcopy(a))
    if res > max_thrust:
        max_thrust = res

print(max_thrust)
'''
