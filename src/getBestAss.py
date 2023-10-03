# 

import sys
sequencesDico=dict()
fasta=open(str(sys.argv[1]), "r")
for l in fasta:
  if l[0]==">":
    AC=l.rstrip().split(">")[1]
    sequencesDico[AC]=""
  else: 
    sequencesDico[AC]+=l.rstrip()        
 
fasta.close()


maxSeq=0
maxAC=""
for seq in sequencesDico:
  test= int(len(sequencesDico[seq]) - sequencesDico[seq].count("N"))
  if test > maxSeq:
    maxSeq = test
    maxAC=seq

print(">"+maxAC)
print(sequencesDico[maxAC])
  


