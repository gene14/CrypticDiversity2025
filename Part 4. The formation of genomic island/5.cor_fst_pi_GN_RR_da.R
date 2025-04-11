### AIMS: using the da as the proxy off divergence time
library(reshape)
library(ggpubr)
library(ggplot2)

fst_dxy_pi_all <- read.csv("11lineages_fst_snp1000.csv")

popname=c("E1", "E2", "E3", "E4", "K1", "K2", "K3", "K4", "R1", "R2", "R3" )
for ( P1 in popname) {
  popname2 <- popname[-which(popname==P1)]
  for ( P2 in popname2) {
    mean_pi <- (fst_dxy_pi_all[,paste("pi_",P1,sep="")]+fst_dxy_pi_all[,paste("pi_",P2,sep="")])/2
    da <- fst_dxy_pi_all[,paste("dxy_",P1,"_",P2,sep="")]-(fst_dxy_pi_all[,paste("pi_",P1,sep="")]+fst_dxy_pi_all[,paste("pi_",P2,sep="")])/2
    fst_dxy_pi_all <- cbind(fst_dxy_pi_all,mean_pi,da)
    fst_dxy_pi_all <-rename(fst_dxy_pi_all,c(mean_pi=paste("mean_pi_",P1,"_",P2,sep="")))
    fst_dxy_pi_all <-rename(fst_dxy_pi_all,c(da=paste("da_",P1,"_",P2,sep="")))
  }
  popname <- popname[-which(popname==P1)]
}

library(dplyr)
write.csv( fst_dxy_pi_all,"da_meanpi.csv",quote=F)
zfst.all <- read.csv("recomrate_gene_count.xls",header = T,sep = "\t")
gene_recomb <- zfst.all[,c(1,2,3,9,10)]

da_meanpi_all <- left_join( fst_dxy_pi_all,gene_recomb,by=c("scaffold","start","end"))

popname=c("E1", "E2", "E3", "E4", "K1", "K2", "K3", "K4", "R1", "R2", "R3" )
data_cor <- data.frame(Fst_vs_pi=NA,dxy_vs_pi=NA,Fst_vs_RR=NA,Fst_vs_GN=NA,pi_vs_RR=NA,pi_vs_GN=NA,da=NA,dxy_vs_RR=NA,dxy_vs_GN=NA)

da_mean_pi <- da_meanpi_all
## Using the loop
## Using assign() function to rename
for ( P1 in popname) {
  popname2 <- popname[-which(popname==P1)]
  for ( P2 in popname2) {
    cor.test(da_mean_pi[,paste("Fst_",P1,"_",P2,sep="")],da_mean_pi[,paste("mean_pi_",P1,"_",P2,sep="")]) -> Fst_vs_pi
    cor.test(da_mean_pi[,paste("dxy_",P1,"_",P2,sep="")],da_mean_pi[,paste("mean_pi_",P1,"_",P2,sep="")]) -> dxy_vs_pi
    cor.test(da_mean_pi[,paste("Fst_",P1,"_",P2,sep="")],da_mean_pi[,"recom.rate"]) -> Fst_vs_RR
    cor.test(da_mean_pi[,paste("Fst_",P1,"_",P2,sep="")],da_mean_pi[,"gene.number"]) -> Fst_vs_GN
    cor.test(da_mean_pi[,paste("mean_pi_",P1,"_",P2,sep="")],da_mean_pi[,"recom.rate"]) -> pi_vs_RR
    cor.test(da_mean_pi[,paste("mean_pi_",P1,"_",P2,sep="")],da_mean_pi[,"gene.number"]) -> pi_vs_GN
    cor.test(da_mean_pi[,paste("dxy_",P1,"_",P2,sep="")],da_mean_pi[,"recom.rate"]) -> dxy_vs_RR
    cor.test(da_mean_pi[,paste("dxy_",P1,"_",P2,sep="")],da_mean_pi[,"gene.number"]) -> dxy_vs_GN
    mean(da_mean_pi[,paste("da_",P1,"_",P2,sep="")]) -> da_E_E_E_N
    rbind(data_cor,unname(c(Fst_vs_pi$estimate,dxy_vs_pi$estimate,Fst_vs_RR$estimate,Fst_vs_GN$estimate,pi_vs_RR$estimate,pi_vs_GN$estimate,da_E_E_E_N,dxy_vs_RR$estimate,dxy_vs_GN$estimate)))->data_cor
  }
  popname <- popname[-which(popname==P1)]
}
write.csv(data_cor,"da_cor.csv",quote=F,sep="\t")
data_cor = na.omit(data_cor)
da_mean_pi <- da_meanpi_all

Fst_vs_pi.plot <- ggplot(data_cor,aes(da,Fst_vs_pi)) +
  geom_point(size=5,col="grey")+
  ylim(-1,1)+
  theme_classic()+
  stat_smooth(method="lm",se=FALSE,col="#264653",lwd=1.2)+
  stat_cor(size=8,col="dark red")+
  geom_hline(yintercept = 0,linetype="dashed")

Fst_vs_pi.plot <- ggplot(data_cor,aes(da,Fst_vs_pi)) +
  geom_point(size=5,col="grey")+
  ylim(-1,1)+
  theme_classic()+
  stat_smooth(method="lm",se=FALSE,col="#264653",lwd=1.2)+
  stat_cor(size=8,col="dark red")+
  geom_hline(yintercept = 0,linetype="dashed")
Fst_vs_pi.plot
## 2
Fst_vs_RR.plot <- ggplot(data_cor,aes(da,Fst_vs_RR)) +
  geom_point(size=5,col="grey")+
  ylim(-1,1)+
  theme_classic()+
  stat_smooth(method="lm",se=FALSE,col="#264653",lwd=1.2)+
  stat_cor(size=8,col="dark red")+
  geom_hline(yintercept = 0,linetype="dashed")
## 3
Fst_vs_GN.plot <- ggplot(data_cor,aes(da,Fst_vs_GN)) +
  geom_point(size=5,col="grey")+
  ylim(-1,1)+
  theme_classic()+
  stat_smooth(method="lm",se=FALSE,col="#264653",lwd=1.2)+
  stat_cor(size=8,col="dark red")+
  geom_hline(yintercept = 0,linetype="dashed")
## 4
pi_vs_GN.plot <- ggplot(data_cor,aes(da,pi_vs_GN)) +
  geom_point(size=5,col="grey")+
  ylim(-1,1)+
  theme_classic()+
  stat_smooth(method="lm",se=FALSE,col="#264653",lwd=1.2)+
  stat_cor(size=8,col="dark red")+
  geom_hline(yintercept = 0,linetype="dashed")
## 5
pi_vs_RR.plot <- ggplot(data_cor,aes(da,pi_vs_RR)) +
  geom_point(size=5,col="grey")+
  ylim(-1,1)+
  theme_classic()+
  stat_smooth(method="lm",se=FALSE,col="#264653",lwd=1.2)+
  stat_cor(size=8,col="dark red")+
  geom_hline(yintercept = 0,linetype="dashed")
## 6
dxy_vs_pi.plot <-ggplot(data_cor,aes(da,dxy_vs_pi)) +
  geom_point(size=5,col="grey")+
  ylim(-1,1)+
  theme_classic()+
  stat_smooth(method="lm",se=FALSE,col="#264653",lwd=1.2)+
  stat_cor(size=8,col="dark red")+
  geom_hline(yintercept = 0,linetype="dashed")

pdf("da_vs_correlations2.pdf",height=12.5,width = 24)
ggarrange(pi_vs_GN.plot,Fst_vs_GN.plot,Fst_vs_pi.plot,pi_vs_RR.plot,Fst_vs_RR.plot, dxy_vs_pi.plot,ncol=3,nrow = 2)
dev.off()
