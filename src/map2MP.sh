#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

minimap2 -ax map-ont $SCRIPT_DIR/../db/ON563414/ON563414.fasta $1_tr.fastq > $1.sam
