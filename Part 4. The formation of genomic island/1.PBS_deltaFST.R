library(reshape)
### set working directory
setwd("set/your/working/directory/")

## input files
fst_nostep <- read.csv("1-input_files/11lineages_fst_dxy_pi_100kb.csv.gz")
poplist <- read.csv("poplist.csv") ### Supplementary Table 4
### input the A, B, C lineages
for ( i in 1:11) {
A_pop <- poplist[i,1]
B_pop <- poplist[i,2]
C_pop <- poplist[i,3]

popname=c("E1", "E2", "E3", "E4","K1", "K2", "K3", "K4", "R1", "R2", "R3" )
popname=sort(popname)
popname2 = popname[-which(popname == A_pop)]
### calculate PBS
PBS <- (-log(1-fst_nostep[, paste("Fst",sort(c(A_pop,B_pop))[1],sort(c(A_pop,B_pop))[2],sep="_")])-
          log(1-fst_nostep[, paste("Fst",sort(c(A_pop,C_pop))[1],sort(c(A_pop,C_pop))[2],sep="_")])+
          log(1-fst_nostep[, paste("Fst",sort(c(B_pop,C_pop))[1],sort(c(B_pop,C_pop))[2],sep="_")]))/2
z <- fst_nostep[,1:4]

### calculate delta FST
z <- fst_nostep[,1:4]
popname2 = popname[-which(popname == A_pop)]
for ( P1 in popname2) {
  popname3 <- popname2[-which(popname2==P1)]
  for ( P2 in popname3) {
    y <- fst_nostep[,paste("Fst",P1,P2,sep="_")]
    z <- cbind(z,y)
    z <- reshape::rename(z,c(y=paste("Fst",P1,P2,sep="_")))
  }
  popname2 <- popname2[-which(popname2==P1)]
}
z_num <- z[,5:49] ### row of FST
row_mean = apply(z_num,1,mean)
z <- cbind(z,row_mean)
delta_fst <- fst_nostep[,paste("Fst",sort(c(A_pop,B_pop))[1],sort(c(A_pop,B_pop))[2],sep="_")] - row_mean

final_data <- cbind(fst_nostep[,1:5],PBS,delta_fst)
final_data <- na.omit(final_data)
final_data$zdelta_fst <- scale(final_data$delta_fst)
final_data$zPBS <- scale(final_data$PBS)
outlier_data <- subset(final_data, final_data$zdelta_fst >=2 & final_data$zPBS >= 2)
write.csv(outlier_data,paste("2-output_outliers/",A_pop,"_outliers.csv",sep = ""))
}

