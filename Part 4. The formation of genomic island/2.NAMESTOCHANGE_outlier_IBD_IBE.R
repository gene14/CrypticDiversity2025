#### Using the GLMM to calculate the IBD and IBE effect in each locus
library(gstat)
library(introgress)
library(MCMCglmm)
library(raster)
library(reshape2)
library(xlsx)
### set working directory: setwd("/set/your/path/")
pop_fst <- read.csv("1-input_files/llineages_fst_dxy_pi.csv.gz")
## input predict factor
# environment
Allenvdist <- read.csv("1-input_files/All_ENV_predictor.csv",row.names = 1)
colnames(Allenvdist) <- row.names(Allenvdist)
Allenvdist <- Allenvdist[sort(colnames(Allenvdist)),sort(colnames(Allenvdist))]
## geographic distance
Geodist <- read.csv("1-input_files/Geo_dist.csv",row.names = 1) 
colnames(Geodist) <- row.names(Geodist)
Geodist <- Geodist[sort(colnames(Geodist)),sort(colnames(Geodist))]
## 
Popname <- read.table("1-input_files/Popname",header = F,sep="\t",row.names = 1)
Popname <- Popname[sort(rownames(Popname)),]
aqmat <- data.frame(t(combn(Popname, 2)) ,stringsAsFactors = FALSE)
names(aqmat) <- c('Pop1', 'Pop2')
aqmat$env <-
  scale(apply(aqmat, 1, function(x) { Allenvdist[x[1],x[2]] }))
aqmat$geo <-
  scale(apply(aqmat, 1, function(x) { Geodist[x[1],x[2]] }))

aqmat1 <- aqmat
slocus <- read.csv(paste("1-input_files/NAMESTOCHANGE.txt",sep=""),header = F)
table_DIC <- data.frame(array(NA,c(length(t(slocus)),4)))
names(table_DIC) <- c('DIC', 'deltaDIC', 'DICweight','predictor')
for ( i in 1:length(t(slocus))) {
  sl <- slocus[i,]
  aqmat1 <- aqmat
locus.fst <- t(pop_fst[sl,c(282:534)])
colnames(locus.fst) <- c("locus.fst")
aqmat1$locus.fst <- locus.fst

## do models
mod.null <- MCMCglmm(fixed = locus.fst ~ 1, 
                     random = ~ idv(mult.memb( ~ Pop1 + Pop2)), data = aqmat1, pr = TRUE, nitt = 2000000, burnin = 500000, thin = 750, verbose = FALSE)
mod.geo <- MCMCglmm(fixed = locus.fst ~ geo, 
                    random = ~ idv(mult.memb( ~ Pop1 + Pop2)), data = aqmat1 , pr = TRUE, nitt = 2000000, burnin = 500000, thin = 750, verbose = FALSE)
mod.env <- MCMCglmm(fixed = locus.fst ~ env, 
                    random = ~ idv(mult.memb( ~ Pop1 + Pop2)), data = aqmat1 , pr = TRUE, nitt = 2000000, burnin = 500000, thin = 750, verbose = FALSE)
mod.geo_env <- MCMCglmm(fixed = locus.fst ~ geo+env, 
                    random = ~ idv(mult.memb( ~ Pop1 + Pop2)), data = aqmat1 , pr = TRUE, nitt = 2000000, burnin = 500000, thin = 750, verbose = FALSE)


DICs <- data.frame(array(NA, c(4, 3)))
names(DICs) <- c('DIC', 'deltaDIC', 'DICweight')
row.names(DICs) <- c('null', 'geo', 'env', 'geo_env')
DICs[,'DIC'] <- c(mod.null$DIC, mod.geo$DIC,mod.env$DIC,mod.geo_env$DIC)
DICs[,'deltaDIC'] <- with(data.frame(DICs), DIC-min(DIC))
DICs[,'DICweight'] <- with(data.frame(DICs), exp(-deltaDIC / 2) / sum(exp(-deltaDIC / 2)))
### filter the max of DIC value
DICmax <- subset(DICs,DICs$DICweight==max(DICs$DICweight))
### output results
write.csv(DICs,paste("output/",slocus[i,],".csv",sep=""))
table_DIC[i,] <- c(DICmax, rownames(DICmax))
}

write.csv(table_DIC,paste("output/NAMESTOCHANGE_DIC_outliers.csv",sep=""))

#### write.csv(DICs, file = '4-results_2/DICs.allchr.all.csv')


