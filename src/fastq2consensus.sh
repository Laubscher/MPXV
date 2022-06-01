#!/bin/bash

echo "Starting.."

echo "logfile; Sample:$1" > $1.log

echo "Getting MPXV specific reads.."

bash getReads.sh $1 $2 2>&1 >>$1.log

echo -e "Found $(wc -l $1.reads)  MPXV specific reads"

rm $1.reads

echo "Map to reference.."

bash map2MP.sh $1 2>&1 >>$1.log

echo "Generate consensus.."

bash sam2consensus.sh $1 2>&1 >>$1.log

echo "Generate coverage plot.."

coverage.r $1.depth 2>&1 >>$1.log
