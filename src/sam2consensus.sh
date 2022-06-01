#!/bin/bash

samtools sort $1.sam -o $1.sorted.bam

samtools index $1.sorted.bam

samtools flagstat $1.sorted.bam > $1.stat

echo "Sample_ACCESSION	Genome_positions	Depth" > $1.depth

samtools depth $1.sorted.bam >> $1.depth

samtools mpileup -A -Q 0 $1.sorted.bam | ivar consensus -p $1_q10_07_m10 -q 10 -t 0.7 -m 10
