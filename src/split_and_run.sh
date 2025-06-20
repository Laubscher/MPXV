#!/bin/bash

# Usage: bash split_and_run.sh input.fastq threads output.fastq

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

set -e

#$1
CPU=$2
amplicon=$3

output_fastq="$1"_tr.fastq
parts=$((CPU - 1))

if [ "$parts" -le 0 ]; then
  echo "Erreur: nombre de threads doit être supérieur à 1"
  exit 1
fi

mkdir -p tmp_fastq

# 1. Diviser le fastq en chunks de 4 lignes (1 read = 4 lignes)
total_lines=$(wc -l < "$1".fastq)
lines_per_chunk=$(( (total_lines / parts / 4) * 4 ))

split -d -l "$lines_per_chunk" --additional-suffix=.fastq "$1".fastq tmp_fastq/chunk_

# 2. Lancer les scripts en parallèle
for chunk in tmp_fastq/*.fastq; 
    do
    chunk_name=$(basename "$chunk" .fastq)
    bash $SCRIPT_DIR/getReads.sh tmp_fastq/$chunk_name 1 $amplicon &
done

# 3. Attendre la fin de tous les processus
wait

# 4. Regrouper les résultats
cat tmp_fastq/chunk_*_tr.fastq > "$output_fastq"

# cleaning
rm -r tmp_fastq

echo "Fastq trimmed written : $output_fastq"

