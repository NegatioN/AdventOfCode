with open('data/day2', 'r') as f:
    data = [x.split() for x in f.read().strip().split('\n')]

m = {'X': 'A', 'Y': 'B', 'Z': 'C'}
data = [(x[0], m[x[1]]) for x in data]


def score_games(data, score_f):
    score = 0
    for x, y in data:
        score += score_f(x, y)
    return score

lookup = {
        'A': {'win': 'C', 'lose': 'B'},
        'B': {'win': 'A', 'lose': 'C'},
        'C': {'win': 'B', 'lose': 'A'},
        }
move_score_map = {'A': 1, 'B': 2, 'C': 3}

def compute(x, y):
    move = y
    if lookup[x]['win'] == y:
        score = 0
    elif x == y:
        score = 3
    else:
        score = 6
    return move_score_map[move] + score

print(score_games(data, compute))

# case 2: X = lose, Y= draw, Z = win
def compute(x, y):
    if y == 'A':
        move, score = lookup[x]['win'], 0
    elif y == 'B':
        move, score = x, 3
    else:
        move, score = lookup[x]['lose'], 6
    return move_score_map[move] + score
print(score_games(data, compute))
