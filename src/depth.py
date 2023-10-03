# 

import sys
listDepth=[]
depth=open(str(sys.argv[1]), "r")
for l in depth:
    value=l.rstrip().split("\t")[2]
    if str(value) != 'Depth':
      listDepth.append(value)

depth.close()

listDepth.sort()
index=int(len(listDepth)/2)
if len(listDepth) % 2 == 0:
  median= float(int(listDepth[index]) + int(listDepth[int(index+1)])) //2
else:
   median=listDepth[index]

print(median)
