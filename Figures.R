#Make some Figures

load(file="/home/din02g/NewSims/BigTestSet/simtiming2.rData")
load(file="/home/din02g/NewSims/BigTestSet/aftiming.rData")
load(file="/home/din02g/NewSims/BigTestSet/bdistdata.rData")

times<-sapply(timing,function(x) x[1]+x[4])
btreedat$atime<-times

bestnam<-c("K_8_FFP","K_7_RTD","K_150_BBC","K_150_ICPIC","2DSV","K_25_2DMV",
           "2DNV","K_6_FCGR","KR")

times<-list()
for (i in bestnam){
  tt<-lapply(aftiming,function(x) x[[i]])
  times[[i]]<-sapply(tt,function(x) x[1]+x[4])
}

tframe<-do.call(cbind,times)

btreedat<-cbind(btreedat,tframe)

nexts<-aggregate(btreedat,by=list(btreedat$n.spp),mean)
tdat<-stack(nexts,c("atime",bestnam))
tdat$n.spp<-rep(nexts$n.spp,length.out=nrow(tdat))
tdat$lval<-log(tdat$values)

library(ggplot2)
p<-ggplot(tdat,aes(n.spp,values))+
  geom_line(aes(colour=ind),size=3)+
  theme_bw() +ylab("Computation Time (seconds)") + xlab("Number of species in pool")+scale_y_log10(breaks=c(1,10,100,1000,10000))+
  theme(axis.title.x = element_text(  size=20),
        axis.text.x  = element_text(vjust=0.5, size=16),axis.title.y = element_text( size=20),
        axis.text.y  = element_text(vjust=0.5, size=16))
p
save(p,file="/home/din02g/Google Drive/AFD-manuscript/Figure3.RData")


p<-ggplot(tdat,aes(n.spp,values))+
  geom_point(aes(colour=ind),size=3)+stat_smooth(aes(colour=ind),method="lm", se=FALSE)+
  theme_bw() +ylab("Computation Time (seconds)") + xlab("Number of species in pool")+
  scale_y_log10(breaks=c(1,10,100,1000,10000))+
  theme(axis.title.x = element_text(  size=20),
        axis.text.x  = element_text(vjust=0.5, size=16),axis.title.y = element_text( size=20),
        axis.text.y  = element_text(vjust=0.5, size=16))
p
 
