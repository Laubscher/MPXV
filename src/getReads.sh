#!/bin/bash
echo "Remove adapters"
porechop -t $2 -i $1.fastq -o $1_tr1.fastq 1> /dev/null # trimming
#REMOVE amplicon primer  à tester
AMPLICON=$3

if [ $AMPLICON == "true" ]; then
  echo "Remove amplicon primers"
  python3 ../../../Téléchargements/Porechop-0.2.4/porechop-runner.py -t $2 --force_all_adapters --end_size 50 --no_split -i $1_tr1.fastq -o $1_tr.fastq
else
  echo "Metagenomic mode"
  mv $(echo $1)_tr1.fastq $(echo $1)_tr.fastq
fi