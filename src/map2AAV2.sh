#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

#minimap2 -ax map-ont $SCRIPT_DIR/../db/OL694814/OL694814.fasta $1_tr.fastq > $1.sam

#minimap2 -ax map-ont $SCRIPT_DIR/../db/TTV16/TTV16.fasta $1_tr.fastq > $1.sam
minimap2 -ax map-ont $SCRIPT_DIR/../db/NC001401/NC001401.fasta $1_tr.fastq > $1.sam
