#!/bin/bash

bash getReads.sh $1

bash map2MP.sh $1

bash sam2consensus.sh $1

coverage.r $1.depth
