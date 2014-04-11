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

corbigord.mean=aggregate(corbigord[,1:2],list(group=corbigord$V3),mean)
corbigord.mean$group<-c("aligned","TRUTH","bbc","icpic","fcgr","rtd","k80","ffp","kr")

corbigord<-corbigord[sample.int(nrow(corbigord)),]

library(wesanderson)
pal1<-wes.palette(5,"Moonrise3")
pal2<-wes.palette(4, "Chevalier")
#pal<-c(pal1,pal2)
#pal<-pal[sample.int(9)]
p<-ggplot(corbigord,aes(V1,V2))+
  geom_point(aes(colour=V3),alpha=0.7,size=5)+
  geom_path(data=df_ell, aes(x=V1, y=V2,linetype=group), size=4,colour="white")+
  geom_path(data=df_ell, aes(x=V1, y=V2,colour=group), size=2, linetype=1)+coord_fixed()+
  theme_bw() +  scale_linetype_manual(values=c(1,1,1,1,1,1,1,1,1,1,1,1),guide="none")+
  #scale_colour_manual(values=pal) +
  annotate("text",x=corbigord.mean$V1,y=corbigord.mean$V2+c(0,0,0,0,0,0,-0.02,0,0),label=corbigord.mean$group,size=c(7,7,7,7,7,7,6,7,7),colour="black") +
  theme(legend.position="none")+ylab("MDS Axis 2") + xlab("MDS Axis 1")+
  theme(axis.title.x = element_text(  size=20),
        axis.text.x  = element_text(vjust=0.5, size=16),axis.title.y = element_text( size=20),
        axis.text.y  = element_text(vjust=0.5, size=16))
p
 
save(p,file="/home/din02g/Google Drive/AFD-manuscript/Figure2.RData")
