#!/bin/bash

#samtools view -q 10 -h $1.sam > $1_Q.sam  #maybe useful map quality filter, settings have to be tested if used big chance to lost the 2 terminal regions ..

samtools sort $1.sam -o $1.sorted.bam

samtools index $1.sorted.bam

echo "Sample_ACCESSION	Genome_positions	Depth" > $1.depth

samtools depth $1.sorted.bam    >> $1.depth

samtools mpileup -A -Q 0 $1.sorted.bam | ivar consensus -p $1_q10_07_m10 -q 10 -t 0.7 -m 10
