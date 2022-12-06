with open('data/day6', 'r') as f:
    data = list(f.read().strip())

step = 14 # part 2 is step = 4
for i in range(0,len(data)-step):
    s = data[i:i+step]
    if len(s) == len(set(s)):
        print(i+step)
        break
