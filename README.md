# MPXV
Scripts to obtain consensus genomes of **Monkeypox virus (MPXV)** using **long reads sequencing** from *Oxford Nanopore Technologies*.  

Setting : minimum depth **10x**

## Usage 

Usage : gMPXV-2025 -v ALL (-a) [fastqPrefix] [nb of cpu]

-a for amplicon option 

need ungziped fastq



## Dependencies:

[Porechop](https://github.com/rrwick/Porechop)  
[samtools](https://github.com/samtools/samtools)  
[minimap2](https://github.com/lh3/minimap2)  
[iVar](https://github.com/andersen-lab/ivar)  
[Rscript](https://cran.r-project.org/) & ggplot2  
Python3 Package: collections, pysam, Bio, sys
