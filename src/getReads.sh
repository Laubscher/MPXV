#!/bin/bash

porechop -i $1.fastq -o $1_tr.fastq 1> /dev/null # trimming
