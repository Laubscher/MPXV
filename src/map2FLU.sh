#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

minimap2 -ax map-ont $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment1.fst $1_tr.fastq > $1_A1.sam

minimap2 -ax map-ont $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment2.fst $1_tr.fastq > $1_A2.sam

minimap2 -ax map-ont $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment3.fst $1_tr.fastq > $1_A3.sam

minimap2 -ax map-ont $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment4.fst $1_tr.fastq > $1_A4.sam

minimap2 -ax map-ont $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment5.fst $1_tr.fastq > $1_A5.sam

minimap2 -ax map-ont $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment6.fst $1_tr.fastq > $1_A6.sam

minimap2 -ax map-ont $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment7.fst $1_tr.fastq > $1_A7.sam

minimap2 -ax map-ont $SCRIPT_DIR/../db/dataBaseFLU2022_V2/A_segment8.fst $1_tr.fastq > $1_A8.sam


