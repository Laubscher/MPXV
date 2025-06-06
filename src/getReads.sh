#!/bin/bash

porechop -i $1.fastq -o $1_tr.fastq 1> /dev/null # trimming
#porechop-runner.py -t 10 --force_all_adapters --end_size 50 --no_split -i <>-tr.fasta -o <>.fastq