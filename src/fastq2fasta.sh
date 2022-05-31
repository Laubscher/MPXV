#!/bin/bash

sed -n '1~4s/^@/>/p;2~4p' $1.fastq > $1.tmp # fastq2fasta

cat $1.tmp | cut -f 1 -d " " > $1.fasta  # cut for small header

rm $1.tmp 
