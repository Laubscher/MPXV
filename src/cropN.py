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



for ac in sequencesDico:
  seq= sequencesDico[ac]
  try :
    while seq[0]=="N":
     seq= seq[1:-1]
    while seq[-1]=="N":
     seq= seq[0:-2]
  
    print(">"+ sys.argv[1].split(".")[0])  #va remplacé l'ac par nom du fichier càd prélévement + segment
    print(seq)
  
  except :
    pass

