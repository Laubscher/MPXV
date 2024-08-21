#!/bin/bash

  SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

  grep "^@SQ" $1.sam | cut -f2 -d ":" | cut -f1 > $1.AC  # on récupère les AC

  maxLen=$(grep "^@SQ" $1.sam | cut -f3 -d ":" | cut -f1  | sort -n -r | head -1)   # on récupère la longueur max

  samtools sort $1.sam -o $1.sorted.bam

  samtools index $1.sorted.bam

  samtools depth $1.sorted.bam >> $1.depth

  python $SCRIPT_DIR/bam2consensus.py $1 $1.AC $maxLen

  #bash bam2consensusIVA.sh $1 #$1.AC $maxLen

  python $SCRIPT_DIR/getBestAss.py $(echo $1).fasta > $(echo $1).fst

  python $SCRIPT_DIR/cropN.py $(echo $1).fst >> $(echo $1).fa  
  
  #second mapping process with the new consensus sequences
  

  #samtools mpileup -A -Q 0 $1.sorted.bam | ivar consensus -p $1_q10_07_m10 -q 10 -t 0.7 -m 10

