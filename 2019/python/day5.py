import os
from common import load_data, get_input
from copy import deepcopy
from functools import partial

cookie = os.environ.get('AOC_COOKIE')

data = load_data(day=5, my_cookie=cookie)

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
             4: {'f': lambda x: print(x), 'n': 1},
             5: {'f': lambda x, y: x != 0, 'n': 2},
             6: {'f': lambda x, y: x == 0, 'n': 2},
             7: {'f': lambda x, y: int(x < y), 'n': 2},
             8: {'f': lambda x, y: int(x == y), 'n': 2},
             }

def execute(op_action):
    f = functions[op_action]
    return f['f'], f['n']

def computer(a, init_f, final_hook_f, debug=False):
  i = 0
  a = init_f(a)
  while i < len(a):
    modes, op_action = format_opcode(a[i], debug=debug)
    if not op_action in valid_opcodes:
        print(f'Halting, erronous opcode: {op_action}')
        break
    i += 1
    op, num_params = execute(op_action)
    params = a[i:i+num_params] # noun_p, verb_p or noun_p

    i += num_params
    values = [mode_interp(val_m)(a, val_p) for val_p, val_m in zip(params, reversed(modes))]

    res = op(*values)
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

  return final_hook_f(a)


a = [int(x) for x in get_input(5).split(',')]

computer(deepcopy(a), init_f=lambda x: x, final_hook_f=print, debug=False)
