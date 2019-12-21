import requests
import os
def load_data(day, my_cookie, year=2019, data_folder='data'):
  p = f'{data_folder}/{year}_{day}.txt'
  if os.path.isfile(p):
    with open(p, 'r') as f:
      return f.read().strip().split('\n')
  
  data = requests.get(f'https://adventofcode.com/{year}/day/{day}/input', cookies={"session": my_cookie}, headers={"User-Agent": 'google Colab'})
  input_text = data.content.decode('utf-8')
  os.makedirs(data_folder, exist_ok=True)
  with open(p, 'w+') as f:
    f.write(input_text)

  return input_text.strip().split('\n')

import sys
import os
def get_input(day, year=2019):
  inp = sys.argv[1]
  if inp == 'run':
      c = os.environ.get('AOC_COOKIE')
      return load_data(day, c, year)
  else:
      return inp
  return a