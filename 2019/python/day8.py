import numpy as np
from common import get_input

data = np.array([int(x) for x in str(get_input(day=8)[0])])

print(data)
print(len(data))

layer = 25*6
layers = []
onec, twoc, threec = [], [], []
c = 0
while c < len(data):
    d = data[c:c+layer]
    layers.append(d)
    onec.append(len(d[d == 0]))
    twoc.append(len(d[d == 1]))
    threec.append(len(d[d == 2]))
    c += layer

i = np.array(onec).argmin()

print(twoc[i] * threec[i])

output = np.zeros(layer)
mask = np.zeros(layer)

for dat in layers:
    dat = np.array(dat)
    sel_mask = np.where((mask == 0) & (dat != 2))[0]
    output[sel_mask] = dat[sel_mask]
    mask[sel_mask] = 1
    if mask.all() == 1:
        break

print("".join([str(x) for x in output.astype(np.int32)]))

#print(output.astype(np.byte).reshape(6, 25))
from PIL import Image

im = Image.fromarray(output.astype(np.uint8).reshape(6, 25) * 255, mode='L')
im.save('test.jpg')
im.resize((500, 120), Image.ANTIALIAS).show()
