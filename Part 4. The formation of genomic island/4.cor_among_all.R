## AIMS: explore the correlations among genomic divergence, diversity,  genetic architecture, and introgressions from non-sister lineages. 
### Junchu Peng
fst_dxy_pi_all <- read.csv("11lineages_fst_snp1000.csv")
fst_dxy_pi_pos <- fst_dxy_pi_all[,1:6]
fst_dxy_pi_num <- fst_dxy_pi_all[,7:127]
### using scale to normolized the data
zfst_zdxy_zpi_num <- scale(fst_dxy_pi_num)
zfst_zdxy_zpi_all <- cbind(fst_dxy_pi_pos,zfst_zdxy_zpi_num)
zfst_zdxy_zpi_all <- cbind(fst_dxy_pi_pos,zfst_zdxy_zpi_num)
zfst_zdxy_zpi_naomit <- na.omit( zfst_zdxy_zpi_all)
## 
zpi1 <- zfst_zdxy_zpi_naomit[,7:17]
zdxy1 <- zfst_zdxy_zpi_naomit[,18:72]
zfst1 <- zfst_zdxy_zpi_naomit[,73:127]
zall_pos <- zfst_zdxy_zpi_naomit[,2:6]
## principle analysis
###Here you need to check whether the correlation coefficient between pc1 and all values ​​is positively correlated.
zpi_pca <- prcomp(zpi1) ### Proportion of Variance of pc1: 0.3413
zdxy_pca <- prcomp(zdxy1) ### Proportion of Variance of pc1: 0.5018
zfst_pca <- prcomp(zfst1) ### Proportion of Variance of pc1: 0.3158
## 
zall_pos_all <- cbind(zall_pos, zpi_pc1 = -zpi_pca$x[,1],  zdxy_pc1 = zdxy_pca$x[,1], zfst_pc1 = zfst_pca$x[,1])
RR_GN <- read.csv("recomrate_gene_count.xls",sep="\t",header = T)

zfst.RR <- left_join(zall_pos_all,RR_GN[,c(1:3,6,7)],by=c("scaffold", "start", "end"))
admix_fd <- read.table("window_based_mean_fd.xls",header = T)
zcor_final_all <- left_join(zfst.RR,admix_fd[,c(1:3,5)],by=c("scaffold", "start", "end"))

library("psych")
library(ggplot2)
library(ggpubr)

cbind(zpi1,zpi_pca$x[,1]) -> zpi_all
cbind(zfst1,zfst_pca$x[,1]) -> zfst_all
cbind(zdxy1,zdxy_pca$x[,1]) -> zdxy_all
ggcorr(zpi_all, label = TRUE, label_size =5, label_round = 2, label_alpha = F) ## make sure the pc1 pi was positively correlated with all pi of each lineages.
ggcorr(zfst_all, label = TRUE, label_size =5, label_round = 2, label_alpha = F)  ## make sure the pc1 Fst was positively correlated with all Fst between each comparisons.
ggcorr(zdxy_all, label = TRUE, label_size =1, label_round = 2, label_alpha = F)  ## make sure the pc1 Fst was positively correlated with all dxy between each comparisons
## output
pdf("correlation_among_chr.pdf",height = 10, width = 10)
ggpairs(zcor_final_all,columns = c(6:11),alpha=0.4,label = TRUE,columnLabels = c("Z-PC1 π","Z-PC1 dxy","Z-PC1 Fst","r (cM/Mbp)","Gene count","mean fd"))
dev.off()
