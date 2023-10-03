#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
#Clade IIA
minimap2 -ax map-ont $SCRIPT_DIR/../db/AY753185/AY753185.fasta $1_tr.fastq > $1.sam
