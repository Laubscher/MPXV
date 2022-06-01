#!/bin/bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

blastn -query $1.fasta -db $SCRIPT_DIR/../db/monkeypox/monkeypox.fasta -num_threads $2 -evalue 1 -num_descriptions 1 -num_alignments 1 > $1_blast.txt
