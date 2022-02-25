#!/usr/bin/env Rscript

library(stringr)
args <- commandArgs(TRUE) 
workdir <- args[1]
genomes <- str_split(args[2], '\n')

for (genome in genomes){
	filename <- paste(workdir, '/results_', str_replace_all(genome, '-', '_'), '/gstats_library_group/')
	varname <- paste("stats_", str_replace_all(genome, '-', '_'), sep="")
	assign(varname, read.table(file = filename, col.names = c("name", genome)))


total <- merge(stats_14_24, stats_14_41, by = "name", all=TRUE)
total <- merge(total, stats_X44, by = "name", all=TRUE)
total <- merge(total, stats_H4_8, by = "name", all=TRUE)

total <- total[order(match(total[,1], stats_X44[,1])),]

file_out <-  paste(workdir, '/aggr_results/aggr_stats.csv')
write.csv(total, file_out, quote=FALSE, sep="\t")
