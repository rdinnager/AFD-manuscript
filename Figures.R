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
  geom_line(aes(colour=ind),size=2)+geom_point(aes(colour=ind),size=3)+scale_color_discrete(name="Method")+
  theme_bw() +ylab("Computation Time (seconds)") + xlab("Number of species in pool")+scale_y_log10(breaks=c(1,10,100,1000,10000))+
  theme(axis.title.x = element_text(  size=20), 
        axis.text.x  = element_text(vjust=0.5, size=16),axis.title.y = element_text( size=20),
        axis.text.y  = element_text(vjust=0.5, size=16))
p
direct.label(p)
save(p,file="/home/din02g/Google Drive/AFD-manuscript/Figure3.RData")


p<-ggplot(tdat,aes(n.spp,values))+
  geom_point(aes(colour=ind),size=3)+stat_smooth(aes(colour=ind),method="lm", se=FALSE)+
  theme_bw() +ylab("Computation Time (seconds)") + xlab("Number of species in pool")+
  scale_y_log10(breaks=c(1,10,100,1000,10000))+
  theme(axis.title.x = element_text(  size=20),
        axis.text.x  = element_text(vjust=0.5, size=16),axis.title.y = element_text( size=20),
        axis.text.y  = element_text(vjust=0.5, size=16))
p


#Clustering figures
load(file="/home/din02g/NewSims/TestSet2/distdata.rData")

library(ape)
library(fastcluster)

cor.dist.to.true<-sapply(cordistlist,function(x) as.matrix(x)[61,])
cor.dist.to.true<-t(cor.dist.to.true)
corfulldat<-cbind(cor.dist.to.true,treedat)

cormeandists<-Reduce("+",cordistlist)/length(cordistlist)
treemeandists<-Reduce("+",treedistlist)/length(treedistlist)

corranks<-apply(1-cor.dist.to.true,1,rank)
ranktest<-apply(corranks,1,mean)
ranksd<-apply(corranks,1,sd)

corclust<-hclust(1-cormeandists,"average")
treeclust<-hclust(treemeandists,"average")
cortree<-as.phylo(corclust)
treetree<-as.phylo(treeclust)
cortree$edge.length<-cortree$edge.length*2
treetree$edge.length<-treetree$edge.length*2

write.tree(cortree,file="/home/din02g/Google Drive/AFD-manuscript/Figure1a.tre")
write.tree(treetree,file="/home/din02g/Google Drive/AFD-manuscript/Figure1b.tre")

par(mfrow=c(1,2),cex=.75,mar=c(5,1,2,0)+0.1) 
plot(cortree, no.margin=F,font=2,main="Branch-length Correlation",tip.color=c(rep("black",60),"darkred"))
axisPhylo()
plot(treetree, no.margin=F,font=2,main="Robinson-Foulds Distance (Topology)",tip.color=c(rep("black",60),"darkred"))
axisPhylo()

par(mfrow=c(1,1),cex=1,mar=c(5, 4, 4, 2) + 0.1) 

links<-matrix(c(cortree$tip.label,treetree$tip.label),nrow=length(cortree$tip.label),ncol=2)
cophyloplot(cortree,treetree,links,space=55,use.edge.length=T,font=1,gap=2,rotate=T)

#Ordination, Figure 2
tree.dist.to.true<-sapply(treedistlist,function(x) as.matrix(x)[61,])
tree.dist.to.true<-t(tree.dist.to.true)
treefulldat<-cbind(tree.dist.to.true,treedat)
test<-apply(corfulldat,2,mean)
test2<-apply(treefulldat,2,mean)
testsd<-apply(corfulldat,2,function(x) sd(x)/length(x))
#best<-c(4,8,9,14,19,20,22,25,28,32,36,37,42,47,48,50,53,56,57,58)
#best<-c(32,36,37,42,47,48,50,53,56,57,58)
best<-c(32,36,37,42,53,56,57,58)
bestnam<-c("UPGMA_K_8_FFP","UPGMA_K_7_RTD","UPGMA_K_150_BBC","UPGMA_K_150_ICPIC","UPGMA_K_6_FCGR",
           "UPGMA_KR","UPGMA_K80","ALIGN","TRUEdist")
best<-which(names(test) %in% bestnam)
#samp<-sample(names(cordistlist),1000)
cortestset<-cordistlist
treetestset<-treedistlist
dattestset<-treedat

library(vegan)
i<-1
treedist<-as.dist(as.matrix((treetestset[[i]]/treedat[i,"n.spp"]))[best,best])
cordist<-as.dist(as.matrix(1-cortestset[[i]])[best,best])
treeref<-cmdscale(treedist)
corref<-cmdscale(cordist)
corref<-t(t(corref)-corref["TRUEdist",])
treeref<-procrustes(corref,treeref)$Yrot
treeref<-t(t(treeref)-treeref["TRUEtree",])
corbigord<-as.data.frame(matrix(nrow=11000,ncol=3))
treebigord<-as.data.frame(matrix(nrow=11000,ncol=3))
for (i in 1:length(cortestset)){
  treedist<-as.dist(as.matrix((treetestset[[names(cortestset)[i]]]/treedat[names(cortestset)[i],"n.spp"]))[best,best])
  cordist<-as.dist(as.matrix(1-cortestset[[names(cortestset)[i]]])[best,best])
  corord<-cmdscale(cordist)
  treeord<-cmdscale(treedist)
  newcor<-as.data.frame(procrustes(corref,corord,truemean=T,scale=F)$Yrot)
  #newcor<-as.data.frame(t(t(newcor)-newcor["TRUEdist",]))
  newcor$meth<-rownames(newcor)
  newtree<-as.data.frame(procrustes(treeref,treeord,truemean=T,scale=F)$Yrot)
  #newtree<-as.data.frame(t(t(newtree)-newtree["TRUEtree",]))
  newtree$meth<-rownames(newtree)
  corbigord[(((i-1)*9)+1):(((i-1)*9)+9),]<-newcor
  treebigord[(((i-1)*9)+1):(((i-1)*9)+9),]<-newtree
  print(i)
}

veganCovEllipse<-function (cov, center = c(0, 0), scale = 1, npoints = 100) 
{
  theta <- (0:npoints) * 2 * pi/npoints
  Circle <- cbind(cos(theta), sin(theta))
  t(center + scale * t(Circle %*% chol(cov)))
}


ord<-ordiellipse(corbigord[,1:2],corbigord$V3,choices=c(1,2))
df_ell <- data.frame()
for(g in levels(as.factor(corbigord$V3))){
  df_ell <- rbind(df_ell, cbind(as.data.frame(with(corbigord[corbigord$V3==g,],
                                                   veganCovEllipse(ord[[g]]$cov,ord[[g]]$center,ord[[g]]$scale)))
                                ,group=g))
}

ord2<-ordiellipse(treebigord[,1:2],treebigord$V3,choices=c(1,2))
df_ell2 <- data.frame()
for(g in levels(as.factor(treebigord$V3))){
  df_ell2 <- rbind(df_ell2, cbind(as.data.frame(with(treebigord[corbigord$V3==g,],
                                                   veganCovEllipse(ord2[[g]]$cov,ord2[[g]]$center,ord2[[g]]$scale)))
                                ,group=g))
}

corbigord.mean=aggregate(corbigord[,1:2],list(group=corbigord$V3),mean)
corbigord.mean$group<-c("aligned","TRUTH","bbc","icpic","fcgr","rtd","k80","ffp","kr")
treebigord.mean=aggregate(treebigord[,1:2],list(group=treebigord$V3),mean)
treebigord.mean$group<-c("aligned","TRUTH","bbc","icpic","fcgr","rtd","k80","ffp","kr")

corbigord<-corbigord[sample.int(nrow(corbigord)),]
treebigord<-treebigord[sample.int(nrow(treebigord)),]

library(wesanderson)
pal1<-wes.palette(5,"Moonrise3")
pal2<-wes.palette(4, "Chevalier")
#pal<-c(pal1,pal2)
#pal<-pal[sample.int(9)]
p<-ggplot(corbigord,aes(V1,V2))+
  geom_point(aes(colour=V3),alpha=0.7,size=5)+
  geom_path(data=df_ell, aes(x=V1, y=V2,linetype=group), size=4,colour="white")+
  geom_path(data=df_ell, aes(x=V1, y=V2,colour=group), size=2, linetype=1,alpha=0.7)+coord_fixed()+
  theme_bw() +  scale_linetype_manual(values=c(1,1,1,1,1,1,1,1,1,1,1,1),guide="none")+
  #scale_colour_manual(values=pal) +
  annotate("text",x=corbigord.mean$V1,y=corbigord.mean$V2+c(0,0,0,0,0,0,-0.02,0,0),label=corbigord.mean$group,size=c(7,7,7,7,7,7,6,7,7),colour="black") +
  theme(legend.position="none")+ylab("MDS Axis 2") + xlab("MDS Axis 1")+
  theme(axis.title.x = element_text(  size=20),
        axis.text.x  = element_text(vjust=0.5, size=16),axis.title.y = element_text( size=20),
        axis.text.y  = element_text(vjust=0.5, size=16))
p
 
save(p,file="/home/din02g/Google Drive/AFD-manuscript/Figure2a.RData")

library(ggplot2)
library(directlabels)
library(wesanderson)
pal1<-wes.palette(5,"Moonrise3")
pal2<-wes.palette(4, "Chevalier")
#pal<-c(pal1,pal2)
#pal<-pal[sample.int(9)]
p<-ggplot(treebigord,aes(V1,V2))+
  geom_point(aes(colour=V3),alpha=0.7,size=5)+
  geom_path(data=df_ell2, aes(x=V1, y=V2,linetype=group), size=4,colour="white")+
  geom_path(data=df_ell2, aes(x=V1, y=V2,colour=group), size=2, linetype=1, alpha=0.7)+
  theme_bw() +  scale_linetype_manual(values=c(1,1,1,1,1,1,1,1,1),guide="none")+
  #scale_colour_manual(values=pal) +
  #annotate("text",x=treebigord.mean$V1,y=treebigord.mean$V2,label=treebigord.mean$group,size=7,colour="black") +
  theme(legend.position="none")+ylab("MDS Axis 2") + xlab("MDS Axis 1")+
  theme(axis.title.x = element_text(  size=20),
        axis.text.x  = element_text(vjust=0.5, size=16),axis.title.y = element_text( size=20),
        axis.text.y  = element_text(vjust=0.5, size=16))
p

save(p,file="/home/din02g/Google Drive/AFD-manuscript/Figure2b.RData")



load(file="/home/din02g/NewSims/TestSet2/TestMetaData.rData")
treefulldat$Div<-corfulldat$Div<-diverg[as.numeric(names(cordistlist))]

mod<-lm(treefulldat$ALIGN~as.factor(treefulldat$Div))

mod<-lm(corfulldat$ALIGN~as.factor(corfulldat$Div))

mod<-lm(corfulldat$UPGMA_KR~as.factor(corfulldat$Div))



#MPD Plot
library(ggplot2)
load(file="/home/din02g/NewSims/TestSet2/MPDdat.RData")
MPDcors<-lapply(fullMPDdat,cor)
MPDacc<-do.call(rbind,lapply(MPDcors,function(x) x["TRUEdist",]))
MPDaccMean<-apply(MPDacc,2,mean)[2:9]
MPDaccStE<-apply(MPDacc,2,function(x) sd(x)/sqrt(length(x)))[2:9]
MPDaccDat<-as.data.frame(cbind(MPDaccMean,MPDaccStE))
MPDaccDat$Metric<-c("FFP \n k=8","RTD \n k=7","BBC \n k=150","ICPIC \n k=150","FCGR \n k=6","Kr","K80","Alignment \n Based")
p<-ggplot(MPDaccDat,aes(y=MPDaccMean,x=as.factor(Metric))) +
  geom_point(size=5) + geom_errorbar(aes(ymax=MPDaccMean+MPDaccStE,ymin=MPDaccMean-MPDaccStE))
p

MPDnew<-as.data.frame(MPDacc[,2:9])
colnames(MPDnew)<-c("FFP \n k=8","RTD \n k=7","BBC \n k=150","ICPIC \n k=150","FCGR \n k=6","Kr","K80","Alignment \n Based")
MPDstack<-stack(MPDnew)
p <- ggplot(MPDstack, values,aes(factor(ind)))+ylim(0,1)
p + geom_violin(width=2,scale="width") + coord_flip()#+geom_point(data=MPDaccDat,y=MPDaccMean,size=5)

p <- ggplot(MPDstack, values,aes(factor(ind)))+ylab("Correlation with \"true\" Branch-lengths") 
p<-p + geom_point(size=3,alpha=0.01,position="jitter")+ylab("Correlation with \"True\" Phylogenetic Diversity (MPD)") + xlab("Phylogenetic Method")+ coord_flip()
p
save(p,file="/home/din02g/Google Drive/AFD-manuscript/Figure4.RData")

#Curvilinear Figure
load(file="/home/din02g/NewSims/TestSet2/distdata.rData")
distmat<-distmat[sample.int(4000,1000)]
rm(MPDdat,PSVdat,cordistlist,treedistlist)
gc()
sdists<-mapply(function(x,y) cbind(Rep=rep(y,ncol(x)),scale(x[,-ncol(x)]),TRUEdist=x[,ncol(x)]),distmat,c(1:length(distmat)))
mdists<-mapply(function(x,y) cbind(Rep=rep(y,ncol(x)),t(t(x)/apply(x,2,max))),distmat,c(1:length(distmat)))
alldists<-as.data.frame(do.call(rbind,sdists))
malldist<-as.data.frame(do.call(rbind,mdists))

require(ggplot2)
require(mgcv)
require(splines)
p <- ggplot( alldists, aes( y=UPGMA_K80, x=TRUEdist ) ) + 
  geom_line( stat="smooth", method="lm", formula=y~ns(x,2), mapping=aes(colour=as.factor(Rep)),size=0.1,fullrange=F,alpha=0.15) +
  scale_color_manual(values=rep("black",length(sdists))) + theme_bw() + theme(legend.position="none") 
p

p <- ggplot( alldists, aes( y=UPGMA_K_8_FFP, x=TRUEdist ) ) + 
  geom_line( stat="smooth", method="lm", formula=y~ns(x,2), mapping=aes(colour=as.factor(Rep)),size=0.1,fullrange=F,alpha=0.2) +
  scale_color_manual(values=rep("black",length(sdists))) + theme_bw() + theme(legend.position="none") 
p

p <- ggplot( alldists, aes( y=UPGMA_KR, x=TRUEdist ) ) + 
  geom_line( stat="smooth", method="lm", formula=y~ns(x,2), mapping=aes(colour=as.factor(Rep)),size=0.1,fullrange=F,alpha=0.2) +
  scale_color_manual(values=rep("black",length(sdists))) + theme_bw() + theme(legend.position="none") 
p

require(ggplot2)
require(mgcv)
require(splines)
p2 <- ggplot( malldist, aes( y=UPGMA_K80, x=TRUEdist ) ) + 
  geom_line( stat="smooth", method="lm", formula=y~ns(x,2), mapping=aes(colour=as.factor(Rep)),size=0.1,fullrange=F,alpha=0.15) +
  geom_abline(intercept=0, slope=1) + ylab("UPGMA Alignment Distance (Kimura 1980)") + xlab("") +
  coord_fixed(1/1.1) + scale_y_continuous(limits=c(0,1.1),breaks=c(0,0.25,0.5,0.75,1.0)) +
  scale_color_manual(values=rep("black",length(sdists))) + theme_bw() + theme(legend.position="none") 
p2

p4 <- ggplot( malldist, aes( y=UPGMA_KR, x=TRUEdist ) ) + 
  geom_line( stat="smooth", method="lm", formula=y~ns(x,2), mapping=aes(colour=as.factor(Rep)),size=0.1,fullrange=F,alpha=0.15) +
  geom_abline(intercept=0, slope=1) + ylab(expression("UPGMA"~K[r]~"Distance")) + xlab("True Phylogenetic Distance") + 
  coord_fixed(1/1.1) + scale_y_continuous(limits=c(0,1.1),breaks=c(0,0.25,0.5,0.75,1.0)) +
  scale_color_manual(values=rep("black",length(sdists))) + theme_bw() + theme(legend.position="none") 
p4

p3 <- ggplot( malldist, aes( y=UPGMA_K_10_FFP, x=TRUEdist ) ) + 
  geom_line( stat="smooth", method="lm", formula=y~ns(x,2), mapping=aes(colour=as.factor(Rep)),size=0.1,fullrange=F,alpha=0.15) +
  geom_abline(intercept=0, slope=1) + ylab("UPGMA FFP Distance (K=10)") + xlab("True Phylogenetic Distance") + 
  coord_fixed(1/1.1) + scale_y_continuous(limits=c(0,1.1),breaks=c(0,0.25,0.5,0.75,1.0)) +
  scale_color_manual(values=rep("black",length(sdists))) + theme_bw() + theme(legend.position="none") 
p3

p1 <- ggplot( malldist, aes( y=ALIGN, x=TRUEdist ) ) + 
  geom_line( stat="smooth", method="lm", formula=y~ns(x,2), mapping=aes(colour=as.factor(Rep)),size=0.1,fullrange=F,alpha=0.15) +
  geom_abline(intercept=0, slope=1) + ylab("Alignment Distance (MUSCLE + RaxML)") + 
  xlab("") + coord_fixed(1/1.1) + scale_y_continuous(limits=c(0,1.1),breaks=c(0,0.25,0.5,0.75,1.0)) +
  scale_color_manual(values=rep("black",length(sdists))) + theme_bw() + theme(legend.position="none") 
p1

p <- ggplot( malldist, aes( y=ALIGN_ULTdist, x=TRUEdist ) ) + 
  geom_line( stat="smooth", method="lm", formula=y~ns(x,2), mapping=aes(colour=as.factor(Rep)),size=0.1,fullrange=F,alpha=0.15) +
  geom_abline(intercept=0, slope=1) +
  scale_color_manual(values=rep("black",length(sdists))) + theme_bw() + theme(legend.position="none") 
p

p <- ggplot( malldist, aes( y=UPGMA_K_7_RTD, x=TRUEdist ) ) + 
  geom_line( stat="smooth", method="lm", formula=y~ns(x,2), mapping=aes(colour=as.factor(Rep)),size=0.1,fullrange=F,alpha=0.15) +
  geom_abline(intercept=0, slope=1) +
  scale_color_manual(values=rep("black",length(sdists))) + theme_bw() + theme(legend.position="none") 
p

library(gridExtra)
grid.arrange(p1,p2,p3,p4)