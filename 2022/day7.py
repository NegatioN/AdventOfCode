with open('data/day7', 'r') as f:
    data = list(map(lambda x: x.split('\n'), f.read().split('$')))[1:]

start = {'children': [], 'parent': None, 'size': 0}
dir_node = start
for x in data:
    cmd = x[0].strip()
    if cmd.startswith('cd'):
        target = cmd[3:]
        if target == '..':
            dir_node = dir_node['parent']
        else:
            dir_node['children'].append('children': [], 'parent': dir_node, 'size': 0})
            dir_node = dir_node['children'][-1]
    elif cmd.startswith('ls'):
        for y in map(lambda y: y.split(), x[1:]):
            if len(y) > 0:
                try:
                    dir_node['size'] += int(y[0])
                except:
                    pass

nodes = []
unprocessed = [start]
while unprocessed:
    node = unprocessed.pop()
    nodes.append(node)
    unprocessed.extend(node['children'])

for x in reversed(nodes):
    if x['parent']:
        x['parent']['size'] += x['size']

print(sum([x['size'] for x in nodes if x['size'] <= 100000])) # part 1

# part2
diff = abs(70000000 - start['size'] - 30000000)
valid = [x for x in nodes if x['size'] >= diff]
print(min(valid, key=lambda x: x['size'])['size'])