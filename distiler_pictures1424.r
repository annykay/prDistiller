chrom_size <- PATH_TO_CHROM_SIZES
ends3 <- PATH_TO_3END_FILE
mboi_path <- PATH_TO_MBOI_TXT
s1424chromSizes <- read.table(chrom_size, col.names=c('scaff', 'length'))

full <- read.table(ends3, col.names=c('scaff', 'start', 'strand'))

MboI <- read.delim(mboi_path, sep=' ', header=FALSE)
	

#full$start <- full$start+full$cumLen
scaff1 <- t(MboI[1, ])
scaff1 <- scaff1[-1, ]

additional <- nrow(scaff1_full) - length(scaff1)
add_list <- rep.int(0, additional)
scaff1 <- c(scaff1, add_list)
scaff1_full$restrPos <- scaff1

genome <- '14-24'
step_size <- 50000
xmax <- 50000
xmin <- 0
ymax <- 80
ymin <- -5
num_scaff <- 1
scaff_names <- s1424chromSizes[,1]
for (i in 2:25){
	num_scaff <- i
	xmin <- 0 
	scaff_name <- scaff_names[i]
	scaff_len <- s1424chromSizes[num_scaff, 2]
	if (scaff_len < step_size){
		step_size <- scaff_len 
		xmax <- scaff_len
	} else {
		step_size <- 50000
		xmax <- step_size 
	}
	scaff1 <- t(MboI[i, ])
	scaff1 <- scaff1[-1, ]
	scaff1 <- apply(data.frame(scaff1), 1, as.numeric)
	
	scaff1_full <- full[full$scaff == scaff_name, ]
	additional <- nrow(scaff1_full) - length(scaff1)
	if (additional > 0) {
		add_list <- rep.int(0, additional)
		scaff1 <- c(scaff1, add_list)
		
	} else {
		scaff1 <- scaff1[1:nrow(scaff1_full)] 
	}
	scaff1_full$restrPos <- scaff1	

	
	fl <- TRUE
	while (fl == TRUE){
		title <- paste('Scaffold ', num_scaff, ', from ', xmin, ' to ', xmax, ' bp, genome ', genome, sep="")
		filename <- paste('pictures/p',genome, 'Scaff', num_scaff, xmin, xmax, '.png', sep="_")
		ggplot(scaff1_full,aes(x=start)) + geom_histogram(binwidth=20) +geom_point(data=scaff1_full, aes(x=restrPos, y=-2), color='#EE6A50') + xlim(xmin,xmax)+ylim(ymin, ymax)+ggtitle(title)	+theme(legend.position = "best")+labs(x='Genome Coordinate', y = 'Amount of Chimeric Reads')
		ggsave(file=filename, plot=last_plot())
		xmin <- xmax
		if ((xmax + step_size) > scaff_len) {
			xmax <- scaff_len
			fl <- FALSE
		} else {
			xmax <- xmax + step_size
		}

	}
}

