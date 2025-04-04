#!/bin/bash

awk '
    NR == 1 { 
        print; next  
    }
    {
        data[$2] = $3;
        sample = $1;
    }
    NR == 2 { min_pos = $2 }  
    { max_pos = $2 }         
    END {
        for (pos = min_pos; pos <= max_pos; pos++) {
            depth = (pos in data) ? data[pos] : 0;
            print sample, pos, depth;
        }
    }
' OFS="\t" "$1"
