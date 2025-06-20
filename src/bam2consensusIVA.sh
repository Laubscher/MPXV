#!/bin/bash
#argument [1] = prfix, [2] = ref,  [3] = CPU, [4] ac_threshold
bam_fname=$1".sorted.bam"
ac_threshold=$4
af_threshold=0.6

>$1.fasta

for seg in $(cat $2); do
 samtools view -bo $1.$seg.bam $bam_fname $seg;
 samtools mpileup -A -Q 0 $1.$seg.bam | ivar consensus -c 0.5 -p $(echo $1_$seg) -q 10 -t $af_threshold -m $ac_threshold
 cat $1_$seg.fa | sed s"/Consensus_//" | sed s"/_threshold_"$(echo $af_threshold)"_quality_10//" | sed s"/"$(echo $1)"_//" >> $1.fasta
 rm $1.$seg.bam $1_$seg.fa
done


#      -c    Minimum insertion frequency threshold(0 - 1) to call consensus. (Default: 0.8)
#                                        0.5 | Insertion with at least 50% of the depth at a position