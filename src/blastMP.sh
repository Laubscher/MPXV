#!/bin/bash
blastn -query $1.fasta -db monkeypox/monkeypox.fasta -num_threads 12 -evalue 1 -num_descriptions 1 -num_alignments 1 > $1_blast.txt
