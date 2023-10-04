#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

echo "test"

minimap2 -ax map-ont $1.fa $(echo $1)_tr.fastq > $(echo $1)_RE.sam   # REmapping

  grep ">" $1.fa | cut -f2 -d ">" > $(echo $1)_RE.AC

  #grep "@SQ" $(echo $1)_RE.sam | cut -f2 -d ":" | cut -f1 > $(echo $1)_RE.AC  # on récupère les AC 

  maxLen=$(grep "^@SQ" $1_RE.sam | cut -f3 -d ":" | cut -f1  | sort -n -r | head -1) # on récupère la longueur max
  echo $maxLen
  maxLen=$(( $maxLen + 100 ))
  echo $maxLen
  samtools sort $(echo $1)_RE.sam -o $(echo $1)_RE.sorted.bam

  samtools index $(echo $1)_RE.sorted.bam

  samtools depth $(echo $1)_RE.sorted.bam >> $(echo $1)_RE.depth

  python $SCRIPT_DIR/bam2consensus.py $(echo $1)_RE $(echo $1)_RE.AC $maxLen

  #On pourait avoir en fichier avec toute les longueurs en miroir à .AC pour être plus "opti" (faudrait modif bam2consensus pour le prendre comme argument)
  

  # mettre sur 2 ligne les fasta  ??


  #python $SCRIPT_DIR/getBestAss.py $(echo $1).fasta > $(echo $1).fst

  python $SCRIPT_DIR/cropN2.py $(echo $1)_RE.fasta >> $(echo $1)_RE.fa


































