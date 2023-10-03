#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

minimap2 -ax map-ont $SCRIPT_DIR/../db/NC006998/NC006998.fasta $1_tr.fastq > $1.sam
