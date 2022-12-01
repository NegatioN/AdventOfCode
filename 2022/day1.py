with open('data/day1', 'r') as f:
    data = f.read().strip().split('\n\n')

true_data = [list(map(int, x.split('\n'))) for x in data]

calories_by_elf = list(map(sum, true_data))

print(max(calories_by_elf))

print(sum(list(sorted(calories_by_elf, reverse=True))[:3]))
