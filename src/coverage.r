#!/usr/bin/env Rscript

library(readr)
library(gplots)
library(ggplot2)
dev.new(width=20, height=4)
int_breaks <- function(x, n = 5) pretty(x, n)[pretty(x, n) %% 1 == 0] 

args <- commandArgs(trailingOnly = TRUE)

covG <- read_delim(args[1], "\t", escape_double = FALSE, trim_ws = TRUE)
ggplot()  + geom_area(data=covG, mapping=aes(x=Genome_positions, y=Depth),alpha=0.2,fill="darkblue") +geom_hline(yintercept = 10,linetype="dashed",color="darkred") + geom_step(data=covG, mapping=aes(x=Genome_positions, y=Depth), col="darkblue")  + xlab("Genome position (base)")  + scale_y_continuous(breaks = int_breaks)
