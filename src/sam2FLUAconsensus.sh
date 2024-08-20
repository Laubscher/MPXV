#!/bin/bash

#samtools view -q 10 -h $1.sam > $1_Q.sam  #maybe useful map quality filter, settings have to be tested if used big chance to lost the 2 terminal regions ..

  echo "FLU" >> $1.log
  samtools sort $1_A1.sam -o $1_A1.sorted.bam
  samtools sort $1_A2.sam -o $1_A2.sorted.bam
  samtools sort $1_A3.sam -o $1_A3.sorted.bam
  samtools sort $1_A4.sam -o $1_A4.sorted.bam
  samtools sort $1_A5.sam -o $1_A5.sorted.bam
  samtools sort $1_A6.sam -o $1_A6.sorted.bam
  samtools sort $1_A7.sam -o $1_A7.sorted.bam
  samtools sort $1_A8.sam -o $1_A8.sorted.bam

  samtools index $1_A1.sorted.bam
  samtools index $1_A2.sorted.bam
  samtools index $1_A3.sorted.bam
  samtools index $1_A4.sorted.bam
  samtools index $1_A5.sorted.bam
  samtools index $1_A6.sorted.bam
  samtools index $1_A7.sorted.bam
  samtools index $1_A8.sorted.bam 
 
  samtools depth $1_A1.sorted.bam >> $1.depth
  samtools depth $1_A2.sorted.bam >> $1.depth
  samtools depth $1_A3.sorted.bam >> $1.depth
  samtools depth $1_A4.sorted.bam >> $1.depth
  samtools depth $1_A5.sorted.bam >> $1.depth
  samtools depth $1_A6.sorted.bam >> $1.depth
  samtools depth $1_A7.sorted.bam >> $1.depth
  samtools depth $1_A8.sorted.bam >> $1.depth

  SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
  
  cat $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment1.fst | grep ">" | cut -f2 -d ">" >> A_segment1.AC
  cat $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment2.fst | grep ">" | cut -f2 -d ">" >> A_segment2.AC
  cat $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment3.fst | grep ">" | cut -f2 -d ">" >> A_segment3.AC
  cat $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment4.fst | grep ">" | cut -f2 -d ">" >> A_segment4.AC
  cat $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment5.fst | grep ">" | cut -f2 -d ">" >> A_segment5.AC
  cat $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment6.fst | grep ">" | cut -f2 -d ">" >> A_segment6.AC
  cat $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment7.fst | grep ">" | cut -f2 -d ">" >> A_segment7.AC
  cat $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment8.fst | grep ">" | cut -f2 -d ">" >> A_segment8.AC

  python $SCRIPT_DIR/bam2consensus.py $(echo $1)_A1 A_segment1.AC 3000
  python $SCRIPT_DIR/bam2consensus.py $(echo $1)_A2 A_segment2.AC 3000
  python $SCRIPT_DIR/bam2consensus.py $(echo $1)_A3 A_segment3.AC 3000

  python $SCRIPT_DIR/bam2consensus.py $(echo $1)_A4 A_segment4.AC 2500
  python $SCRIPT_DIR/bam2consensus.py $(echo $1)_A5 A_segment5.AC 2500
  python $SCRIPT_DIR/bam2consensus.py $(echo $1)_A6 A_segment6.AC 2500

  python $SCRIPT_DIR/bam2consensus.py $(echo $1)_A7 A_segment7.AC 2000
  python $SCRIPT_DIR/bam2consensus.py $(echo $1)_A8 A_segment8.AC 2000
  
  python $SCRIPT_DIR/getBestAss.py $(echo $1)_A1.fasta > $(echo $1)_A1.fst
  python $SCRIPT_DIR/cropN.py $(echo $1)_A1.fst > $(echo $1).fa

  python $SCRIPT_DIR/getBestAss.py $(echo $1)_A2.fasta > $(echo $1)_A2.fst
  python $SCRIPT_DIR/cropN.py $(echo $1)_A2.fst >> $(echo $1).fa

  python $SCRIPT_DIR/getBestAss.py $(echo $1)_A3.fasta > $(echo $1)_A3.fst
  python $SCRIPT_DIR/cropN.py $(echo $1)_A3.fst >> $(echo $1).fa

  python $SCRIPT_DIR/getBestAss.py $(echo $1)_A4.fasta > $(echo $1)_A4.fst
  python $SCRIPT_DIR/cropN.py $(echo $1)_A4.fst >> $(echo $1).fa

  python $SCRIPT_DIR/getBestAss.py $(echo $1)_A5.fasta > $(echo $1)_A5.fst
  python $SCRIPT_DIR/cropN.py $(echo $1)_A5.fst >> $(echo $1).fa

  python $SCRIPT_DIR/getBestAss.py $(echo $1)_A6.fasta > $(echo $1)_A6.fst
  python $SCRIPT_DIR/cropN.py $(echo $1)_A6.fst >> $(echo $1).fa

  python $SCRIPT_DIR/getBestAss.py $(echo $1)_A7.fasta > $(echo $1)_A7.fst
  python $SCRIPT_DIR/cropN.py $(echo $1)_A7.fst >> $(echo $1).fa
  
  python $SCRIPT_DIR/getBestAss.py $(echo $1)_A8.fasta > $(echo $1)_A8.fst
  python $SCRIPT_DIR/cropN.py $(echo $1)_A8.fst >> $(echo $1).fa

