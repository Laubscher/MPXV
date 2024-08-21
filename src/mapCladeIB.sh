#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
#Clade IB
minimap2 -ax map-ont $SCRIPT_DIR/../db/1b/1bconsensus2024.fasta $1_tr.fastq > $1.sam
