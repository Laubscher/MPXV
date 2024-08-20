#!/bin/bash
 # attention ON EST SUR DU TARGETED l'algo devrait être adapter pour du metagénomique afin de recperer que les AC pertinents là on fait ainsi car on a des base de donnée ciblé aussi

#samtools view -q 10 -h $1.sam > $1_Q.sam  #maybe useful map quality filter, settings have to be tested if used big chance to lost the 2 terminal regions ..

  SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

  grep "^@SQ" $1.sam | cut -f2 -d ":" | cut -f1 > $1.AC  # on récupère les AC

  maxLen=$(grep "^@SQ" $1.sam | cut -f3 -d ":" | cut -f1  | sort -n -r | head -1)   # on récupère la longueur max

  samtools sort $1.sam -o $1.sorted.bam

  samtools index $1.sorted.bam

  samtools depth $1.sorted.bam >> $1.depth

  python $SCRIPT_DIR/bam2consensus.py $1 $1.AC $maxLen

  #bash bam2consensusIVA.sh $1 #$1.AC $maxLen
  
  #On pourait avoir en fichier avec toute les longueurs en miroir à .AC pour être plus "opti" (faudrait modif bam2consensus pour le prendre comme argument)
   
  python $SCRIPT_DIR/getBestAss.py $(echo $1).fasta > $(echo $1).fst

  python $SCRIPT_DIR/cropN.py $(echo $1).fst >> $(echo $1).fa  
  
  #second mapping process with the new consensus sequences
  





  #samtools mpileup -A -Q 0 $1.sorted.bam | ivar consensus -p $1_q10_07_m10 -q 10 -t 0.7 -m 10

