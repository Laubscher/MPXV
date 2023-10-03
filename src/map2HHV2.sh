#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

#minimap2 -ax map-ont $SCRIPT_DIR/../db/MT903344/MT903344.fasta $1_tr.fastq > $1.sam

 #test with USA genome
minimap2 -ax map-ont $SCRIPT_DIR/../db/NC001798/NC001798.fasta $1_tr.fastq > $1.sam
