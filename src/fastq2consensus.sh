#!/bin/bash

echo "Starting.."

echo "logfile; Sample:$1" > $1.log

echo "Getting MPXV specific reads.."

bash getReads.sh $1 $2

echo -e "Found $(wc -l $1.reads) MPXV specific reads"

#cleaning 1

rm $1.reads $1_blast.txt $1_MP.fastq $1.fasta

echo "Map to reference.."

bash map2MP.sh $1

echo "Generate consensus.."

bash sam2consensus.sh $1

#cleaning 2

rm $1.sam $1_tr.fastq $1_q10_07_m10.qual.txt #$1_Q.sam

echo "Generate coverage plot.."

coverage.r $1.depth
