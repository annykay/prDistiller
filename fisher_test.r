#!/usr/bin/env Rscript
library(stringr)
library(stats)
args <- commandArgs(TRUE) 
workdir <- args[1]
genomes <- str_split(args[2], '\n')
file_chim <- 'coverages/chimers3_inters.cov'
file_unique <- 'coverages/unique3_inters.cov'
df <- data.frame(names = c("statistic", "p.value", "test"))

for (genome in genomes){
	workdir <- paste(workdir,'/results_', str_replace_all(genome, '-', '_'), '/gmapped_parsed_sorted_chunks/', sep='')
	setwd(workdir)

	chimers <- read.table(file_chim)
	chim_no <- sum(chimers$V4 == 0)
	chim_yes <- nrow(chimers) - chim_no
	uniq <- read.table(file_unique)
	uniq_no <- sum(uniq$V4 == 0)
	uniq_yes <- nrow(uniq) - uniq_no
	conj <- matrix(c(chim_yes, chim_no, uniq_no, uniq_yes),
	      	nrow = 2,
	       dimnames = list(Chim = c("Yes", "No"),
    		               Unique = c("Yes", "No")))
	res <- fisher.test(conj, alternative = "less")  
	result <- c(res[['statistic']], res[['p.value']], 'fisher')
	df[,genome] <- result
}

filepath_res <- paste(workdir, '/aggr_results/fisher_test.csv')
write.csv(df, file=filepath_res, quote=FALSE, sep="\t")
