### AIMS: the density plot of da in Aquilegia kansuensis and Aquilegia rockii based on the 5-kb windows
### AUTHOR:Junchu Peng
library(reshape)
fst_5kb <- read.csv("11lineages_fst_dxy_pi_invariant_5kb.csv")
### calculate the da
popname=c("E1", "E2", "E3", "E4", "K1", "K2", "K3", "K4", "R1", "R2", "R3" )
for ( P1 in popname) {
  popname2 <- popname[-which(popname==P1)]
  for ( P2 in popname2) {
    mean_pi <- (fst_5kb[,paste("pi_",P1,sep="")]+fst_5kb[,paste("pi_",P2,sep="")])/2
    da <- fst_5kb[,paste("dxy_",P1,"_",P2,sep="")]-(fst_5kb[,paste("pi_",P1,sep="")]+fst_5kb[,paste("pi_",P2,sep="")])/2
    fst_5kb <- cbind(fst_5kb,mean_pi,da)
    fst_5kb <-rename(fst_5kb,c(mean_pi=paste("mean_pi_",P1,"_",P2,sep="")))
    fst_5kb <-rename(fst_5kb,c(da=paste("da_",P1,"_",P2,sep="")))
  }
  popname <- popname[-which(popname==P1)]
}

kan_aims_all <- fst_5kb[,c(1,2,3,5,196,198,200,154,172,228)]
rockii_aims_all <- fst_5kb[,c(1,2,3,5,232,234,228,180)]
write.table(kan_aims_all,"kan_all_da.xls",quote = F,row.names=F,sep="\t")
write.table(rockii_aims_all,"rockii_all_da.xls",quote = F,row.names=F,sep="\t")
### Then use the bedtools to intersect the fixed loci with the da files
kan_aims <- read.table("kan_aims_da.xls",header = T)
rockii_aims <- read.table("rockii_aim_da.xls",header = T)
rockii_sub <- subset(rockii_aims_all,rockii_aims_all$sites >= 50)
kan_sub <- subset(kan_aims_all,kan_aims_all$sites >= 50)

library(ggplot2)
library(ggpubr)
K1_K2.plot <- ggplot()+geom_density(aes(kan_sub$da_K1_K2),fill="gray",col="grey",alpha=0.5)+
  geom_line(data = data.frame(x=c(mean(kan_aims$da_K1_K2),mean(kan_aims$da_K1_K2)),y=c(0,Inf)),aes(x=x,y=y),color="#00616b",size=1.5)+
  geom_line(data = data.frame(x=c(mean(kan_sub$da_K1_K2),mean(kan_sub$da_K1_K2)),y=c(0,Inf)),aes(x=x,y=y),linetype="dotted",size=1.5)+
  xlim(0,0.4) + theme_bw() +
  xlab("K1 - K2 da (T1)") + ylab("density")
K1_K3.plot <- ggplot()+geom_density(aes(kan_sub$da_K1_K3),fill="gray",col="grey",alpha=0.5)+
  geom_line(data = data.frame(x=c(mean(kan_aims$da_K1_K3),mean(kan_aims$da_K1_K3)),y=c(0,Inf)),aes(x=x,y=y),color="#00616b",size=1.5)+
  geom_line(data = data.frame(x=c(mean(kan_sub$da_K1_K3),mean(kan_sub$da_K1_K3)),y=c(0,Inf)),aes(x=x,y=y),linetype="dotted",size=1.5)+
  xlim(0,0.4) + theme_bw() +
  xlab("K1 - K3 da (T1)") + ylab("density")
K1_K4.plot <- ggplot()+geom_density(aes(kan_sub$da_K1_K4),fill="gray",col="grey",alpha=0.5)+
  geom_line(data = data.frame(x=c(mean(kan_aims$da_K1_K4),mean(kan_aims$da_K1_K4)),y=c(0,Inf)),aes(x=x,y=y),color="#00616b",size=1.5)+
  geom_line(data = data.frame(x=c(mean(kan_sub$da_K1_K4),mean(kan_sub$da_K1_K4)),y=c(0,Inf)),aes(x=x,y=y),linetype="dotted",size=1.5)+
  xlim(0,0.4) + theme_bw() +
  xlab("K1 - K4 da (T1)") + ylab("density")
E2_K2.plot <- ggplot()+geom_density(aes(kan_sub$da_E2_K2),fill="gray",col="grey",alpha=0.5)+
  geom_line(data = data.frame(x=c(mean(kan_aims$da_K1_K2),mean(kan_aims$da_K1_K2)),y=c(0,Inf)),aes(x=x,y=y),color="#00616b",size=1.5)+
  geom_line(data = data.frame(x=c(mean(kan_sub$da_E2_K2),mean(kan_sub$da_E2_K2)),y=c(0,Inf)),aes(x=x,y=y),linetype="dotted",size=1.5)+
  xlim(0,0.4) + theme_bw() +
  xlab("E2 - K2 da (T1)") + ylab("density")
E3_K3.plot <- ggplot()+geom_density(aes(kan_sub$da_E3_K3),fill="gray",col="grey",alpha=0.5)+
  geom_line(data = data.frame(x=c(mean(kan_aims$da_K1_K3),mean(kan_aims$da_K1_K3)),y=c(0,Inf)),aes(x=x,y=y),color="#00616b",size=1.5)+
  geom_line(data = data.frame(x=c(mean(kan_sub$da_E3_K3),mean(kan_sub$da_E3_K3)),y=c(0,Inf)),aes(x=x,y=y),linetype="dotted",size=1.5)+
  xlim(0,0.4) + theme_bw() +
  xlab("E3 - K3 da (T1)") + ylab("density")
R2_K4.plot <- ggplot()+geom_density(aes(kan_sub$da_K4_R2),fill="gray",col="grey",alpha=0.5)+
  geom_line(data = data.frame(x=c(mean(kan_aims$da_K1_K4),mean(kan_aims$da_K1_K4)),y=c(0,Inf)),aes(x=x,y=y),color="#00616b",size=1.5)+
  geom_line(data = data.frame(x=c(mean(kan_sub$da_K4_R2),mean(kan_sub$da_K4_R2)),y=c(0,Inf)),aes(x=x,y=y),linetype="dotted",size=1.5)+
  xlim(0,0.4) + theme_bw() +
  xlab("R2 - K4 da (T1)") + ylab("density")
pdf("kan_fixed_invariant_site50_da3.pdf",width=15,height = 8)
ggarrange(K1_K2.plot,K1_K3.plot,K1_K4.plot,E2_K2.plot,E3_K3.plot,R2_K4.plot,ncol=3,nrow = 2)
dev.off()
## fixed site in Aquilegia Rockii
R1_R2.plot <- ggplot()+geom_density(aes(rockii_sub$da_R1_R2),fill="gray",col="grey",alpha=0.5)+
  geom_line(data = data.frame(x=c(mean(rockii_aims$da_R1_R2),mean(rockii_aims$da_R1_R2)),y=c(0,Inf)),aes(x=x,y=y),color="#328c44",size=1.5)+
  geom_line(data = data.frame(x=c(mean(rockii_sub$da_R1_R2),mean(rockii_sub$da_R1_R2)),y=c(0,Inf)),aes(x=x,y=y),linetype="dotted",size=1.5)+
  xlim(0,0.4) + theme_bw() +
  xlab("R1 - R2 da (T1)") + ylab("density")

R1_R3.plot <- ggplot()+geom_density(aes(rockii_sub$da_R1_R3),fill="gray",col="grey",alpha=0.5)+
  geom_line(data = data.frame(x=c(mean(rockii_aims$da_R1_R3),mean(rockii_aims$da_R1_R3)),y=c(0,Inf)),aes(x=x,y=y),color="#328c44",size=1.5)+
  geom_line(data = data.frame(x=c(mean(rockii_sub$da_R1_R3),mean(rockii_sub$da_R1_R3)),y=c(0,Inf)),aes(x=x,y=y),linetype="dotted",size=1.5)+
  xlim(0,0.4) + theme_bw() +
  xlab("R1 - R2 da (T1)") + ylab("density")

K4_R2.plot <- ggplot()+geom_density(aes(rockii_sub$da_K4_R2),fill="gray",col="grey",alpha=0.5)+
  geom_line(data = data.frame(x=c(mean(rockii_aims$da_R1_R2),mean(rockii_aims$da_R1_R2)),y=c(0,Inf)),aes(x=x,y=y),color="#328c44",size=1.5)+
  geom_line(data = data.frame(x=c(mean(rockii_sub$da_K4_R2),mean(rockii_sub$da_K4_R2)),y=c(0,Inf)),aes(x=x,y=y),linetype="dotted",size=1.5)+
  xlim(0,0.4) + theme_bw() +
  xlab("K4 - R2 da (T1)") + ylab("density")

E3_R3.plot <- ggplot()+geom_density(aes(rockii_sub$da_E3_R3),fill="gray",col="grey",alpha=0.5)+
  geom_line(data = data.frame(x=c(mean(rockii_aims$da_R1_R3),mean(rockii_aims$da_R1_R3)),y=c(0,Inf)),aes(x=x,y=y),color="#328c44",size=1.5)+
  geom_line(data = data.frame(x=c(mean(rockii_sub$da_E3_R3),mean(rockii_sub$da_E3_R3)),y=c(0,Inf)),aes(x=x,y=y),linetype="dotted",size=1.5)+
  xlim(0,0.4) + theme_bw() +
  xlab("E3 - R3 da (T1)") + ylab("density")

pdf("rockii_fixed_invariant_site50_da3.pdf",width=10,height = 8)
ggarrange(R1_R2.plot,R1_R3.plot,K4_R2.plot,E3_R3.plot,ncol=2,nrow = 2)
dev.off()







