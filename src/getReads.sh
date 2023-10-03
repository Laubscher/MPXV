#!/bin/bash

#bash fastq2fasta.sh $1

#test without preBlasting
#bash blastMP.sh $1 $2

#grep -B9 ">" $1_blast.txt | sort | uniq | grep "Query=" | cut -d" " -f2 > $1.reads

#grep -A3 -f $1.reads $1.fastq | sed /^--$/d > $1_MP.fastq   # no empty line in .reads !!
cp $1.fastq $1_MP.fastq
#cp $1.fastq $1_tr.fastq
porechop -i $1_MP.fastq -o $1_tr.fastq 1> /dev/null # trimming
