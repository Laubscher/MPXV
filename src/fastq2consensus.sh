#!/bin/bash

echo "Starting.."

echo "logfile; Sample:$1" > $1.log

virus=$3

#echo "Getting MPXV specific reads.."

bash getReads.sh $1 $2

#echo -e "Found $(wc -l $1.reads) MPXV specific reads"

#cleaning 1

rm $1.reads $1_blast.txt $1_MP.fastq $1.fasta

echo "Map to reference.."

echo $virus

if [ $virus == "MPXV" ]
  then bash map2MP.sh $1
  fi
if [ $virus == "HHV1" ]
  then bash map2HHV1.sh $1
  fi
if [ $virus == "HHV2" ]
  then bash map2HHV2.sh $1
  fi
if [ $virus == "VV" ]
  then bash map2VV.sh $1
  fi

echo "Generate consensus.."

bash sam2consensus.sh $1

#cleaning 2

rm $1.sam $1_tr.fastq $1_q10_07_m10.qual.txt #$1_Q.sam

echo "Generate coverage plot.."

coverage.r $1.depth
