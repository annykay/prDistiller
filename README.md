# prDistiller
Here are some scripts to process Distiller-nf output results and perform statistical test 

How to use: 

Put in genomes.txt names of genomes you used for your analysis. It should be the same, as in the distiller-nf. 
After that run 

./main.sh $WD

where WD - is the working directory, where the results of the pipeline are stored. Also it should contain restriction sites of MboI enzyme, obtained from juciertools 
