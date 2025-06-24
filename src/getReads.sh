#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

#One CPU per job 
echo "Remove adapters"
python3 $SCRIPT_DIR/../porexop/porechop-runner.py -i $1.fastq -o $1_tr1.fastq #1> /dev/null # trimming
#REMOVE amplicon primer  à tester
AMPLICON=$3

if [ $AMPLICON == "true" ]; then
  echo "Remove amplicon primers"
  python3 $SCRIPT_DIR/../porexop/porechop-runner-mpox.py --force_all_adapters --end_size 50 --no_split -i $1_tr1.fastq -o $1_tr.fastq
else
  echo "Metagenomic mode"
  mv $(echo $1)_tr1.fastq $(echo $1)_tr.fastq
fi