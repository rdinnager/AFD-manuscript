---
title: "AFD_Draft1"
author: "Russell Dinnage"
date: "Wednesday, April 09, 2014"
output:
  html_document:
    self_contained: yes
bibliography: "/home/din02g/Google Drive/References/AFD.bib"
---

#Abstract

Phylogenetic diversity metrics incorporate information about genetic relatedness of organisms, giving a more nuanced understanding of organismal diversity than species richness alone. Rapidly assessing phylogenetic diversity for surveyed sites will contribute greatly to biodiversity assessment efforts, but this is hampered by the necessity of sequence alignment, which is slow, especially with many species or loci. Alignment-free methods of generating phylogenies and genetic distances have great potential for rapid generation of phylogenetic diversity estimates of local communities, because their execution times scale well with species number and genetic length, and are unaffected by taxon sampling. We evaluated the utility of alignment-free methods using simulated data. We simulated molecular evolution for 20 genes across 156 randomly generated trees, and then created 4000+ simulated communities of 10-50 randomly chosen species, using 3-12 randomly chosen genes, mimicking taxon sampling. We calculated accuracy for the methods by comparing their topology and branch-lengths to those of the original input phylogeny. We found that in most cases, alignment-free methods had comparable accuracy to the alignment-based methods. One of the alignment-free methods (Kr) consistently outperformed the alignment-based method. Likewise, phylogenetic diversity metrics based on the alignment-free metrics were as good and sometimes better correlated with the true phylogenetic diversity than was the alignment-based phylogenetic diversity estimate. These results suggest that phylogenetic community ecologists can greatly reduce time spent in generating phylogenies, while still incorporating accurate genetic information into diversity metrics. Additionally, alignment-free methods are unaffected by the species pool, so that phylogenetic diversity estimates will not change if new species are added to the analysis. Lastly, because alignment-free diversity metric methods do not require identifying homologous genes regions, there is potential to modify them so they can be used before species or genes are identified in metagenomics samples, giving a rapid first analysis of diversity without extensive bioinformatics.

# Introduction

Ecologists have increasingly recognized the need to incorporate genetic information into community analysis methods (ref). The important goals of understanding the different types of diversity, how diversity is generated and maintained, and the consequences of diversity can all be greatly aided when we stop treating individual species as interchangeable entities and instead treat them as non-independent points along an evolutionary continuum. In order to incorporate the genetic relatedness of species, and thus account for their shared evolutionary history, community ecologists have developed new diversity metrics which incorporate the information contained in molecular phylogenies to weight the contribution of species to the diversity of a community based on how much novel or distinctive evolutionary history they contribute (ref). However, this requires the construction of a phylogeny, which is a non-trivial task for ecologists when there is no ready-made phylogeny available for a group of interest. This problem will only get worse as we enter the age of cheap high throughput sequencing technology. With the advent of metagenomics, ecologists will increasingly be faced with the boon of enormous amounts of genetic information, and the curse of having to find a way to efficiently analyse it. Utilizing such large amounts of data to understand diversity will be a major challenge in particular for community phylogenetics, as building a phylogeny becomes more complicated and extremely computationally intensive for large genetic datasets.

One approach to dealing with this explosion of data is to simply filter out most of it and just focus on a few genes, which is largely the approach which has been used to date (refs). The purpose of this study is to investigate ways to utilize all the available data, while greatly reducing the amount of time and computational effort required to achieve results of comparable quality, and perhaps even higher quality, than those of traditional phylogenetic methods.

Phylogenies often contain more information than is required by ecologists to answer their questions of interest. Phylogenies are usually treated as a proxy for what ecologists are really interested in: traits (ref). Species traits – or phenotype – controls how species interact with their environment and other species, and so they drive the ecology of communities (ref). Phylogeny is a proxy for trait divergence because traits are the product of evolutionary history and so – all else being equal – closely related species will share similar traits on average more than distantly related ones, because they have had less time to diverge (ref). Phylogenies contain two main pieces of information: branch lengths – the amount of evolutionary time or genetic divergence between species – and branching order (or topology) – the order in which species have diverged, which determines things like sister species, and monophyly. The development of phylogenetic methods has largely been concerned with achieving high accuracy in the second of these two pieces of information, the branching order or topology of the generated phylogenetic trees, because this is the information most relevant for systematists, who have developed the methods. We would argue, however, that it is the first piece of information contained in phylogenies, the branch lengths, that are of most interest to ecologists. Afterall, the branching order hardly matters if we are mainly interested in the average degree of divergence among species, which is what we expect to be correlated with the amount of trait divergence. Therefore, we propose that ecologists can dispense with time-consuming steps designed to increase topological accuracy in phylogenetic reconstruction, and in many cases, work with raw genetic data to generate diversity metrics of similar utility to phylogenetic diversity metrics. 

## Alignment-free Genomic diversity Metrics

One of the most time-consuming and difficult steps in phylogenetic reconstruction is the alignment of multiple sequences together. The purpose of alignment is to estimate homology – that is, which regions of the sequence should be compared with which regions in other sequences (ref). Establishing homology is important to estimate accurate tree topologies, and is also important for estimating branch lengths in traditional phylogenetic methods, because with insertions and deletions in sequences, unaligned sequences may contain evolutionarily unrelated nucleotides at the same position in different sequences. Alignment is computationally expensive because it usually proceeds by aligning all species to all other species, and combining these pair-wise alignments. This means that for N species, N(N-1)/2 alignments need to be made. 


Alignment is also difficult for automated algorithms to do, especially in genomic sequences and highly diverged sequences where genome rearrangements make determining homology very challenging (refs). Also, in large genetic datasets, alignments cannot be checked by eye because they are too large. The accuracy of alignments is also affected taxon sampling. Generally, distantly related species are more accurately aligned if the dataset includes other species which are evolutionarily intermediate between them. This can lead to different phylogenetic estimates depending on which species are included in the analysis, which is particularly a problem for community ecologists, because communities are usually a highly incomplete subset of represented taxonomic groups. 

In response to the challenge of aligning large genomic datasets, a number of alternative “alignment-free” methods of phylogenetic reconstruction have been proposed (refs). Most of these methods proceed by generating pair-wise genetic distances between species using rapid methods that do not need to establish homology first. Trees are then constructed using hierarchical clustering methods. Despite the very different philosophy of constructing these trees – harkening to the days of ‘phenetics’ (refs) – most work has focused on achieving comparable topological accuracy to traditional alignment-based methods (alignment-free methods so far  are less topologically accurate: refs).


For ecologists, alignment-free methods offer an opportunity to streamline the way we measure phylogenetic diversity. Many phylogenetic diversity metrics use pair-wise distances which are derived from a phylogeny. For these metrics, ecologists would no longer even have to do the tree-building step, we can use the alignment-free genetic distances directly. For those methods that do need the tree, ecologists can generate the tree with hierarchical clustering, which is extremely fast.

The goal of this study is to determine the alignment-free methods, and their particular tuning parameters, which maximize the correspondence of phylogenetic diversity metrics calculated using them and the ‘true’ phylogenetic diversity, by finding the best possible correlation between alignment-free genetic distance and the branch lengths of an underlying phylogeny used to simulate genomics sequences. We will also compare the performance of these alignment-free methods with those that use alignments. Lastly, we will use a real genomic dataset to see how well these same alignment-free genetic distances correlate with the ecological trait-based distances between a set of aquatic insect taxa.


# **Methods**

## Simulated Datasets

## *Simulated genomes from simulated phylogenies*

In order to test the accuracy of different alignment-free methods, we first simulated genomic data using known, underlying phylogenies. We based our analysis on a set of 156 randomly generated phylogenies. Each phylogeny was simulated under a birth-death process using the Artificial Life Framework (ALF) software (ref). All trees used the same birth rate (0.04) and death rate (0.025) parameters, and were run until each phylogeny had 300 terminal species. We used three different divergence rates (52 phylogenies for each) such that the maximum divergence achieved in the phylogeny was high -- 800 PAM units (ref), medium -- 600 PAM units, or low -- 300 PAM units.  (explain what a PAM unit is here)(ref)

The ALF software simulates the evolution of genomic sequences along these input phylogenies using various parameters to customize the results. We used a standard set of parameters for all phylogenies for consistently, with the goal of a realistically complex evolutionary model. We simulated 20 independendent genes across each phylogeny to form our 'genome'. The overall sequence substitution model we used was the 'CPAM' model, which simulates sequences evolution by using empirical codon substitution rates. Insertion and deletions happened at a base rate of 0.0001 per substitution with their length determined by a Zipfian (ref) distribution with parameter 1.821 (the default), with a maximum length of 50. Substitution rate variation between different genes was incorporated using 5 randomly assigned substitution classes with a gamma distribution with alpha and beta parameter equal to 1, and a proportion of invariable sites equal to 0.01. Rate heterogeniety among the 20 genes was also allowed and was distributed according to a gamma distribution with alpha and beta parameter of 1. Gene length was distributed according to a gamma distribution (with alternate parameterization) with parameter k set to 2.4019, and theta set to 133.8063 (ref). 

## *Simulated communities*

We used the 152 simulated phylogenies and their accompanying genomes to create two different sets of simulated communities, to test different aspects of the alignment-free methods.

* Community Set 1: 
This set consists of 4000 randomly generated communities, containing from 10-50 species. This set is designed to compare alignment-based phylogenetic distances and topology to alignment-free methods when there is strong taxon sampling. Because alignment-based methods' required computational resources increase rapidly with the number of species, this set is the only one where we could achieve a high replication rate within a reasonable timescale. Each community consisted of 10-50 (uniformly drawn) randomly selected species from a randomly chosen base phylogeny. For each species in each community, a unique genome was assigned by selecting from 2-12 (uniformly drawn) genes out of the 20 available from the sequence simulations described above.
* Community Set 2:
This set consists of 30 communities which vary from 30 to all 300 species, in intervals of 30, sampled from only three of the original phylogenies, one from each of the divergence categories. This smaller set was used to test how taxon sampling affects each of the different methods of estimating genetic distance and phylogenetic topology. Additionally, we used this set to get an estimate of the time it takes for each of the methods to achieve their results, and how this scales with the number of species. Each species in each community had the same randomly chosen set of 3 genes in this set. 
(Note: I want to redo this analysis for two more reps, with 10 genes and 20 genes, to see how time scales with genome length as well, but this will take awhile to run)
Each community in these sets will be considered a regional species pool. Later, we also generate sub-communities which represent local communities so that we can test the ability of the different phylogenetic methods to accurately reflect phylogenetic structure based on the underlying tree.

## Estimating genetic distances and phylogenies

For each community we generated a matrix of genetic distances between all species, and created phylogenetic trees, using several different methods.


### *Alignment-based Method*

For each community we aligned each of the 2-10 simulated genes seperately using Muscle software (ref) with the default settings. We then concatenated these aligned genes together to create a genetic supermatrix. We chose Muscle because it is used frequently in the literature, and because it is one of the fastest alignment methods, and so is likely to be used in situations where there is a lot of data.
We then used this supermatrix to create a maximum likelihood phylogeny using the software RaxML (ref). Again, we chose this software because it is the fastest ML phylogeny program available, and is the only one that can feasibly create phylogenies from massive datasets.

Genetic distances were drawn from this phylogeny by generated all pairwise distance by measuring the branchlengths seperating two species on the tree. We generated two sets of distances, one with the raw phylogeny from the ML analysis, the other from the same phylogeny, only with its branches rescaled to form an ultrametric tree using penalized likelihood (lambda=1) (ref: Sanderson) in the 'chronopl' function in R package 'ape'(ref). 

### *Alignment-free Methods*

For each community, we also generated genetic distance estimates using methods which do not require alignment, and then created phylogenies from these genetic distances using heirarchical clustering (UPGMA: ref), using the 'fastcluster' package in R (ref).

We generated alignment-free genetic distances using the following methods: 

**Methods based on k-mers words frequency**

* Feature Frequency Profiles (FFP; @Jun2010)
* Return Time Distribution (RTD; ref)
* Frequency Chaos Game Representation (FCGR: ref)

**Methods based on substrings**

* Shortest Unique Substring based method (K~r~; @Haubold2009)

**Methods based on information theory**

* Base-base Correlation (BBC; ref)
* Information correlation and partial information correlation (ICPIC; ref)

**Methods based on DNA graphical representation**

* 2D Graphical Representation-Statistical Vector (2DSV; ref)
* 2D Graphical Representation-Moment Vector (2DMV; ref)
* 2D Graphical Representation-Natural Vector (2DNV; ref) 

These methods have been thoroughly described elsewhere, but for the reader's benefit we provide a brief description here.

**FFP**

blah blah

**RTD**

blah blah

**FCGR**

blah blah

**Kr**

blah blah

**BBC**

blah blah

**ICPIC**

blah blah

**2DSV**

blah blah

**2DMV**

blah blah

**2DNV**

blah blah

All methods were implemented using the python package "Alignment-free Genome Phylogeny (AGP)" available from http://www.herbbol.org:8000/agp and described in @Cheng2013. The functions in this package were interfaced to R using the rpython package (ref); code available as (insert URL of github site here once its up). 

### Comparing estimated genetic distances and topology to the truth

### Diversity Metrics 

### Comparing ecological distance to genetic distances

#### *Dataset*

#### *Statistical Analysis*

#**Results**

#**Discussion**

Despite considerable work on the development of alignment free methods of phylogenetic reconstruction of the past two decades, the use of alignment followed by model-based phylogenetic inference is still the most common way to analyse genetic data. Because of this historic preference for alignment based methods, ecologists who have had to construct there own phylogenies for phylogenetic ecological analyses have largerly followed suit. But is there a simpler and faster way that ecologists can produce phylogenies of comparable usefulness, expecially for increasingly massive ecological datasets? This study would suggest that there is: alignment free methods. Here, we showed that many alignment free methods produce as good, and often better approximations to an underlying 'true' phylogeny.

In the introduction to this paper, we wrote about how ecologists are mainly interested in branchlengths, rather than the topology of phylogenetic trees, because it is phylogenetic distance which is the most likely to predict species' differences in their ecology. Here, we showed that several alignment free methods better reflected phylogenetic distance than the alignment based method. However, we showed that the phylogenies generated from heirarchical clustering of alignment free genetic distances were also more topologically accurate than the alignment based method. It makes sense that if your branchlengths are poorly estimated, this will affect the accuracy of topological reconstruction, especially if some branchlengths are very similar. So we expect branchlength and topological accuracy to be strongly but not perfectly correlated. If this is the case more generally, then why have people continued to use alignment based methods? Part of the answer is that there are surprisingly few studies that actually compare the performance of alignment based methods with alignment free methods.

When introducing new alignment free methods, studies usually test the performance of them using simulation. However, most of these studies use an alignment based method as the baseline. They conclude that if their alignment free method correlates well with the alignment based method then it is a good method. However, this assumes the alignment based method is reflecting the underlying 'true' phylogeny well, if not, then being less correlated with it could in fact be considered a good thing. A review of several alignment free methods (ref) compared the alignment free based phylogenies to a maximum likelihood phylogeney estimated using the known 'true' alignment, and concluded they did more poorly. This is clearly not a fair comparison, as the alignment part of the alignment based method was not undertaken. Another review that properly tested several alignment based methods against a full alignment based method (ref), concluded, similarly to this study, that they were more accurate. The fact is that most studies assume that alignment is the best way to go, because of a bias towards a particular philosophy of phylogenetic reconstruction: that it should be based on an evolutionary model.

The main reason that alignment based methods are the method of choice is because of the post-alignment step, which is explicitly model based. There is a strong desire to couch a phylogenetic hypothesis in a modeling framework, allowing the possibility of discussing the merits of alternative models, and allowing better expression of uncertainty. Indeed, this is a solid argument for modeling approaches, but until recently these modeling approaches require an initial step, which usually does not involve a model of evolution: sequence alignment (or homology estimation). Sequence alignment algorithms are generally heuristic methods rather than an explicit model of any process, introducing some arbitrariness into the overall approach. Indeed most evolutionary models of sequence evolution assume that the input alignment is the true alignment. This is probably why there has been an increasing interest in simultaneously modeling alignment and phylogenetic inference, with some recent progress (refs). This is a promising area, however, these techniques at the moment are very time-consuming, especially for large datasets. Since most systematists study single small taxonomic groups in individual studies, the amount of divergence is small, and the issues with accurate alignment are consequently also small. But modelling sequence evolution allows systematists to get the information they want. In this study we have modelled much greater evolutionary divergence and levels of taxon sampling than usually seen in most systematic studies, but which are frequently encountered by ecologists.

Modelling evolution is most important when trying to distinguish the order of branching of organisms that have fairly similar branchlengths between them. When branchlengths vary greatly, it is simple to find which organisms groups together and how they nest within different groups. Combined with other considerations -- chiefly choosing an appropriate outgroup -- we can use a phylogenetic topology to infer past evolutionary events. Systematists in particular are interested in getting this right, and especially for those more ambiguous groups who are all similarly related to each other. On the other hand, for ecologists, knowing which of a groups of similarly related organisms fall into the same natural grouping is of much less relevance. Regardless of which groups diverged first, if they have similar branchlengths between them, they are expected to have a similar degree of ecological divergence. For ecologists, getting the overall pattern of branchlengths correct should be the first priority. Based on the results of this study, we would recommend using an alignment free method for ecological studies, particularly the metric introduced by (ref): K~r~, which outperformed the other metrics, and has a number of other benefits as well.

K~r~ is the only alignment free method tested here to be based on an evolutionary model, which is perhaps why it is as accurate as it is. The evolutionary model allows Kr to be an estimate of a quantity that diverges linearly with time, meaning it should reflect time since divergence well. Most other metrics are known to theoretically diverge with increasing sequence divergence, but there is no guarantee that this divergence is linear with respect to the evolutionary processes generating the differences, namely basepair substitutions occuring at a particular rate through time. Indeed, most alignment free distance metrics diverge rapidly with initial evolutionary change in a sequence but then rapidly saturate as these changes become greater (fig ?). A way of dealing with this issue has recently been proposed, whereby k-mer based distance are adjusted in a taxon specific way using machine learning techniques (ref). However, the adjustments are trained on subset of 'known' distances, which are based on a sequence alignment. This is useful if we want our alignment free methods to produce an answer as similar as possible to the answer using alignment. K~r~ has an additional advantage over some of the other methods in that it has no parameters. K-mer based methods, on the other hand, require choosing a value for the word length K, and it is not always clear a priori which is the best. Most studies have concluded that a value of K somewhere between 6 and 12 works well (refs), and this study supports that as well. K~r~ is also potentially extendable, since it is model based. More complex models could be incorporated into its calculation, uncertainty could be incorporated, or its basic modelling principles could be incorporated into a full evolutionary model taking place across a tree instead of just a single pairwise pathway, allowing full phylogenetic estimation in one go without alignment. The authors point out that K~r~ becomes less more less stable and upwardly biased when the average number of substitutions per site become greater than about 0.6. In our study we show that this issue causes no worse a problem for correlation with the true branchlengths than it does for the alignment based method used here.

Overall, this study does not support the wholesale replacement of alignment based techniques by alignment free methods. We only looked at one combination of alignment based techniques; others might perform better. However, we used a combination of alignment based methods likely to be used in situations with large datasets, because of their relatively rapid execution times. There are many other alignment methods besides MUSCLE which may work better in our situation, and also many other methods for constructing phylogenies, once an alignment is obtained, besides RAxML, such as Bayesian methods and other slower maximum likelihood algorithms. (I think we are going to have to look at some more alignment based methods before we publish this, I don't think reviewers are going to buy this. Easily doable but will take some time given the slowness of alignment based methods. My suggestion is that I use a smaller subset of the replications to run other alignment based combos on, just to show they are (hopefully) consistent with the main result). 

#**References**




