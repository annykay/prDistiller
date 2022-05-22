#!/bin/bash

WORKDIR=$1 
echo $WORKDIR
while read GENOME
do
	echo $GENOME 
	./make_MboI.r $WORKDIR $GENOME
	GENOME_=${GENOME//-/_} 
	./binarize.sh $GENOME $WORKDIR'/results_'$GENOME_'/gmapped_parsed_sorted_chunks/'
done < genomes.txt
mkdir aggr_results 
