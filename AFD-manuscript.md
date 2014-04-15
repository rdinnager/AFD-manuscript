Abstract
========

Phylogenetic diversity metrics incorporate information about genetic
relatedness of organisms, giving a more nuanced understanding of
organismal diversity than species richness alone. Rapidly assessing
phylogenetic diversity for surveyed sites will contribute greatly to
biodiversity assessment efforts, but this is hampered by the necessity
of sequence alignment, which is slow, especially with many species or
loci. Alignment-free methods of generating phylogenies and genetic
distances have great potential for rapid generation of phylogenetic
diversity estimates of local communities, because their execution times
scale well with species number and genetic length, and are unaffected by
taxon sampling. We evaluated the utility of alignment-free methods using
simulated data. We simulated molecular evolution for 20 genes across 156
randomly generated trees, and then created 4000+ simulated communities
of 10-50 randomly chosen species, using 3-12 randomly chosen genes,
mimicking taxon sampling. We calculated accuracy for the methods by
comparing their topology and branch-lengths to those of the original
input phylogeny. We found that in most cases, alignment-free methods had
comparable accuracy to the alignment-based methods. One of the
alignment-free methods (Kr) consistently outperformed the
alignment-based method. Likewise, phylogenetic diversity metrics based
on the alignment-free metrics were as good and sometimes better
correlated with the true phylogenetic diversity than was the
alignment-based phylogenetic diversity estimate. These results suggest
that phylogenetic community ecologists can greatly reduce time spent in
generating phylogenies, while still incorporating accurate genetic
information into diversity metrics. Additionally, alignment-free methods
are unaffected by the species pool, so that phylogenetic diversity
estimates will not change if new species are added to the analysis.
Lastly, because alignment-free diversity metric methods do not require
identifying homologous genes regions, there is potential to modify them
so they can be used before species or genes are identified in
metagenomics samples, giving a rapid first analysis of diversity without
extensive bioinformatics.

Introduction
============

Ecologists have increasingly recognized the need to incorporate genetic
information into community analysis methods (e.g. Faith 1992;
Srivastava2012; Winter, Devictor, and Schweiger 2012). The important
goals of understanding the different types of diversity, how diversity
is generated and maintained, and the consequences of diversity can all
be greatly aided when we stop treating individual species as
interchangeable entities and instead treat them as non-independent
points along an evolutionary continuum. In order to incorporate the
genetic relatedness of species, and thus account for their shared
evolutionary history, community ecologists have developed new diversity
metrics which incorporate the information contained in molecular
phylogenies to weight the contribution of species to the diversity of a
community based on how much novel or distinctive evolutionary history
they contribute (Faith 1992; Hardy and Senterre 2007; Webb et al. 2002;
Cadotte et al. 2010; Helmus et al. 2007). However, this requires the
construction of a phylogeny, which is a non-trivial task for ecologists
when there is no ready-made phylogeny available for a group of interest.
This problem will only get worse as we enter the age of cheap high
throughput sequencing technology. With the advent of metagenomics,
ecologists will increasingly be faced with the boon of enormous amounts
of genetic information, and the curse of having to find a way to
efficiently analyse it. Utilizing such large amounts of data to
understand diversity will be a major challenge in particular for
community phylogenetics, as building a phylogeny becomes more
complicated and extremely computationally intensive for large genetic
data-sets.

One approach to dealing with this explosion of data is to simply filter
out most of it and just focus on a few genes, which is largely the
approach which has been used to date. The purpose of this study is to
investigate ways to utilize all the available data, while greatly
reducing the amount of time and computational effort required to achieve
results of comparable quality, and perhaps even higher quality, than
those of traditional phylogenetic methods.

Phylogenies often contain more information than is required by
ecologists to answer their questions of interest. Phylogenies are
usually treated as a proxy for what ecologists are really interested in:
traits (Cavender-Bares et al. 2009; Webb et al. 2002; Wiens et al. 2010;
Flynn et al. 2011). Species traits---or phenotype---controls how species
interact with their environment and other species, and so they drive the
ecology of communities (e.g. McGill et al. 2006; Violle and Jiang 2009;
Webb et al. 2010; Cadotte, Albert, and Walker 2013; Ackerly and Cornwell
2007; Messier, McGill, and Lechowicz 2010). Phylogeny is a proxy for
trait divergence because traits are the product of evolutionary history
and so, all else being equal, closely related species will share similar
traits on average more than distantly related ones, because they have
had less time to diverge. Phylogenies contain two main pieces of
information: branch lengths: the amount of evolutionary time or genetic
divergence between species, and branching order (or topology): the order
in which species have diverged, which determines things like sister
species and monophyly. The development of phylogenetic methods has
largely been concerned with achieving high accuracy in the second of
these two pieces of information, the branching order or topology of the
generated phylogenetic trees, because this is the information most
relevant for systematists, who have developed the methods. We would
argue, however, that it is the first piece of information contained in
phylogenies, the branch lengths, that are of most interest to
ecologists. After all, the branching order hardly matters if we are
mainly interested in the average degree of divergence among species,
which is what we expect to be correlated with the amount of trait
divergence. Therefore, we propose that ecologists can dispense with
time-consuming steps designed to increase topological accuracy in
phylogenetic reconstruction, and in many cases, work with raw genetic
data to generate diversity metrics of similar utility to phylogenetic
diversity metrics.

Alignment-free Genomic diversity Metrics
----------------------------------------

One of the most time-consuming and difficult steps in phylogenetic
reconstruction is the alignment of multiple sequences together. The
purpose of alignment is to estimate homology – that is, which regions of
the sequence should be compared with which regions in other sequences
(Phillips 2006; Morgan and Kelchner 2010; Hein et al. 2000; Lunter et
al. 2008). Establishing homology is important to estimate accurate tree
topologies, and is also important for estimating branch lengths in
traditional phylogenetic methods, because with insertions and deletions
in sequences, unaligned sequences may contain evolutionarily unrelated
nucleotides at the same position in different sequences. Alignment is
computationally expensive because it usually proceeds by aligning all
species to all other species, and combining these pair-wise alignments.
This means that for *N* species, \$\\frac{N(N-1)}{2}\$ alignments need
to be made.

Alignment is also difficult for automated algorithms to do, especially
in genomic sequences and highly diverged sequences where genome
rearrangements make determining homology very challenging (Phillips
(2006)). Also, in large genetic data-sets, alignments cannot be checked
by eye because they are too large. The accuracy of alignments is also
affected taxon sampling. Generally, distantly related species are more
accurately aligned if the data-set includes other species which are
evolutionarily intermediate between them. This can lead to different
phylogenetic estimates depending on which species are included in the
analysis, which is particularly a problem for community ecologists,
because communities are usually a highly incomplete subset of
represented taxonomic groups.

In response to the challenge of aligning large genomic data-sets, a
number of alternative “alignment-free” methods of phylogenetic
reconstruction have been proposed (Vinga and Almeida 2003; Cheng, Cao,
and Liu 2013). Most of these methods proceed by generating pair-wise
genetic distances between species using rapid methods that do not need
to establish homology first. Trees are then constructed using
hierarchical clustering methods. Despite the very different philosophy
of constructing these trees---hearkening to the days of ‘phenetics’
(Sokal 1986; Sneath and Sokal 1973)---most work has focused on achieving
comparable topological accuracy to traditional alignment-based methods.

For ecologists, alignment-free methods offer an opportunity to
streamline the way we measure phylogenetic diversity. Many phylogenetic
diversity metrics use pair-wise distances which are derived from a
phylogeny. For these metrics, ecologists would no longer even have to do
the tree-building step, we can use the alignment-free genetic distances
directly. For those methods that do need the tree, ecologists can
generate the tree with hierarchical clustering, which is extremely fast.

The goal of this study is to determine the alignment-free methods, and
their particular tuning parameters, which maximize the correspondence of
phylogenetic diversity metrics calculated using them and the ‘true’
phylogenetic diversity, by finding the best possible correlation between
alignment-free genetic distance and the branch lengths of an underlying
phylogeny used to simulate genomics sequences. We will also compare the
performance of these alignment-free methods with those that use
alignments. Lastly, we will use a real data-set to see how well these
same alignment-free genetic distances correlate with the ecological
trait-based distances between a set of plant taxa.

**Methods**
===========

Simulated Datasets
------------------

### *Simulated genomes from simulated phylogenies*

In order to test the accuracy of different alignment-free methods, we
first simulated genomic data using known, underlying phylogenies. We
based our analysis on a set of 156 randomly generated phylogenies. Each
phylogeny was simulated under a birth-death process using the Artificial
Life Framework (ALF) software (Dalquen et al. 2012). All trees used the
same birth rate (0.04) and death rate (0.025) parameters, and were run
until each phylogeny had 300 terminal species. We used three different
divergence rates (52 phylogenies for each) such that the maximum
divergence achieved in the phylogeny was high: 800 PAM units, medium:
600 PAM units, or low: 300 PAM units. A PAM unit is the number of point
accepted mutations--changes that replace a single amino acid in a
protein with another, and are accepted by natural selection (Dayhoff,
Schwartz, and Orcutt 1978)--that have occurred per 100 amino acids.

The ALF software simulates the evolution of genomic sequences along
these input phylogenies using various parameters to customize the
results. We used a standard set of parameters for all phylogenies for
consistently, with the goal of a realistically complex evolutionary
model. We simulated 20 independent genes across each phylogeny to form
our 'genome'. The overall sequence substitution model we used was the
'CPAM' model, which simulates sequences evolution by using empirical
codon substitution rates. Insertion and deletions happened at a base
rate of 0.0001 per substitution with their length determined by a
Zipfian distribution with parameter 1.821 (the default), with a maximum
length of 50. Substitution rate variation between different genes was
incorporated using 5 randomly assigned substitution classes with a gamma
distribution with alpha and beta parameter equal to 1, and a proportion
of invariable sites equal to 0.01. Rate heterogeneity among the 20 genes
was also allowed and was distributed according to a gamma distribution
with alpha and beta parameter of 1. Gene length was distributed
according to a gamma distribution (with alternate parameterization) with
parameter k set to 2.4019, and theta set to 133.8063.

### *Simulated communities*

All community simulations were conducted in the statistical language 'R'
(R Development Core Team 2010). We used the 152 simulated phylogenies
and their accompanying genomes to create two different sets of simulated
communities, to test different aspects of the alignment-free methods.

-   Community Set 1: This set consists of 4000 randomly generated
    communities, containing from 10-50 species. This set is designed to
    compare alignment-based phylogenetic distances and topology to
    alignment-free methods when there is strong taxon sampling. Because
    alignment-based methods' required computational resources increase
    rapidly with the number of species, this set is the only one where
    we could achieve a high replication rate within a reasonable
    timescale. Each community consisted of 10-50 (uniformly drawn)
    randomly selected species from a randomly chosen base phylogeny. For
    each species in each community, a unique genome was assigned by
    selecting from 2-12 (uniformly drawn) genes out of the 20 available
    from the sequence simulations described above.
-   Community Set 2: This set consists of 30 communities which vary from
    30 to all 300 species, in intervals of 30, sampled from only three
    of the original phylogenies, one from each of the divergence
    categories. This smaller set was used to test how taxon sampling
    affects each of the different methods of estimating genetic distance
    and phylogenetic topology, when considering the entire community.
    Each species in each community had the same randomly chosen set of 3
    genes in this set.
-   Community Set 3: This set consists of 270 communities. Using three
    different underlying phylogenies of medium divergence (600 PAM
    units), we first chose 25 species randomly to be the focal species.
    To test how adding additional species into the phylogenetic analysis
    affected how accurately different methods reconstructed the topology
    and branch-lengths of these 25 focal species, we created 30
    communities with 10 additional species, 30 communities with 40
    additional species and 30 communities with 75 additional species (30
    communities X 3 levels of species sampling X 3 underlying
    phylogenies = 270 communities). (Note: I want to redo this analysis
    for two more reps, with 10 genes and 20 genes, to see how time
    scales with genome length as well, but this will take awhile to run)

Additionally, we used sets 2 and 3 to get an estimate of the time it
takes for each of the methods to achieve their results, and how this
scales with the number of species.

### *Simulated Sub-Communities*

Each community in the above sets will be considered a regional species
pool. We also generated sub-communities which represent local
communities so that we can test the ability of the different
phylogenetic methods to accurately reflect phylogenetic structure based
on the underlying tree. We did this analysis on a sub-set of Community
Set 1---2000 of the 4000 communities were chosen at random because of
time constraints. To do the comparison, we simulated local community
assembly from the regional species pool for 90 communities. We simulated
local 30 communities for each of three different species richness
levels: 24% of the regional pool, 36% of the regional pool, and 48% of
the regional pool. Within each species richness level 10 communities
were simulated under a 'phylogenetically under-dispersed' model, 10 were
randomly simulated, and 10 were "phylogenetically over-dispersed". Each
simulation consisted of an initial random assembly step, where 40%, 60%
and 80% (for the three species richness levels) of the regional pool
were randomly selected, followed by a 'filtering' step. The three
communities 'filtering' models were based modified from Kraft et al.
(2007):

-   **Phylogenetically under-dispersed:** The community was reduced in
    size to 60% of its initial size by sequentially finding the smallest
    phylogenetic distance based on the 'true' tree and removing on of
    the two species in this pair. This was repeated until the desired
    species richness level was achieved.
-   **Phylogenetically random:** 60% of the initial species were simply
    chosen randomly, without regard to their phylogenetic distance to
    other species.
-   **Phylogenetically over-dispersed:** The community was reduced to
    60% its initial size by first choosing a random species from the
    pool and retaining it. The most closely related species to this
    initial species, according to the 'true' phylogeny, was then found
    and retained, and this species became a new seed for the next step.
    Then the algorithm found the closest relative to this new seed, and
    this species was retained, and became the new seed. This process was
    repeated until the number of retained species matched the desired
    species richness.

This process generated communities that spanned the possible range of
phylogenetic diversity in each regional pool.

Estimating genetic distances and phylogenies
--------------------------------------------

For each community we generated a matrix of genetic distances between
all species, and created phylogenetic trees, using several different
methods.

### *Alignment-based Method*

For each community we aligned each of the 2-10 simulated genes
separately using MUSCLE software (Edgar 2004) with the default
settings---e.g.:

    muscle64 -in unaligned.fa -out alignment.fa

We then concatenated these aligned genes together to create a genetic
supermatrix. We chose MUSCLE because it is used frequently in the
literature, and because it is one of the fastest alignment methods, and
so is likely to be used in situations where there is a lot of data. We
then used this supermatrix to create a maximum likelihood (ML) phylogeny
using the software RaxML (Stamatakis 2014)---with the following
settings:

    raxmlHPC-PTHREADS-AVX -s alignment.fa -n outfile -m GTRGAMMA -T 4 -p 1149135 -w temppath

Again, we chose this software because it is the fastest ML phylogeny
program available and, besides FastTree (Price, Dehal, and Arkin 2010),
is the only one that can feasibly create phylogenies from massive
data-sets.

Genetic distances were drawn from this phylogeny by generated all
pairwise distance by measuring the branch-lengths separating two species
on the tree. We generated two sets of distances, one with the raw
phylogeny from the ML analysis, the other from the same phylogeny, only
with its branches rescaled to form an ultrametric tree using penalized
likelihood (lambda=1) (Sanderson 2002) in the 'chronopl' function in R
package 'ape' (Paradis, Claude, and Strimmer 2004).

We created one additional alignment-based distance, without referencing
the phylogeny. We calculated a pairwise genetic distance matrix directly
from the alignment using the Kimura (1980) model of base-pair
substitution ("K80" distance). A phylogeny was created from this
distance matrix using UPGMA and neighbour-joining (NJ) algorithms, using
the 'fastcluster' (Müllner 2013), and 'ape' packages, respectively, in
R. The same methods were applied on all pairwise genetic distance
matrices generated from alignment-free methods, as described below.

### *Alignment-free Methods*

For each community, we also generated genetic distance estimates using
methods which do not require alignment, and then created phylogenies
from these genetic distances using hierarchical clustering (UPGMA) and
neighbour-joining algorithms(NJ).

We generated alignment-free genetic distances using the following
methods, based on Cheng, Cao, and Liu (2013):

**Methods based on k-mer word frequency**

-   Feature Frequency Profiles (FFP; Jun et al. 2010)
-   Return Time Distribution (RTD; Kolekar, Kale, and Kulkarni-Kale
    2012)
-   Frequency Chaos Game Representation (FCGR: Hatje and Kollmar 2012)

**Methods based on substrings**

-   Shortest Unique Substring based method (K<sub>r</sub>; Haubold et
    al. (2009))

**Methods based on information theory**

-   Base-base Correlation (BBC; Liu and Sun 2008)
-   Information correlation and partial information correlation (ICPIC;
    Gao and Luo 2012)

**Methods based on DNA graphical representation**

-   2D Graphical Representation-Statistical Vector (2DSV; Huang et al.
    2011)
-   2D Graphical Representation-Moment Vector (2DMV; Yu et al. 2010)
-   2D Graphical Representation-Natural Vector (2DNV; Deng et al. 2011)

These methods have been thoroughly described elsewhere (e.g. see Cheng,
Cao, and Liu 2013), but for the reader's benefit we provide a brief
description here. (**Note:** This will be easy but tedious (rewording
pointlessly the original description). Can we get away with just quoting
from the original paper? Never understood why direct quoting seems to
not be used in biology, this type of thing would be the perfect place
for it.)

**FFP**

blah blah

**RTD**

blah blah

**FCGR**

blah blah

**K<sub>r</sub>**

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

All methods were implemented using the python package "Alignment-free
Genome Phylogeny (AGP)" available from <http://www.herbbol.org:8000/agp>
and described in Cheng, Cao, and Liu (2013). The functions in this
package were interfaced to R using the rpython package (ref); code
available as (insert URL of github site here once its up).

### Comparing estimated genetic distances and topology to the truth

We compared the branch-lengths and topology of all methods to the 'true'
phylogeny and to each other. For the "K80" alignment based distances and
all of the alignment-free methods, we compared the raw distances by
calculating the pierson correlation between the distances of all pairs
of species. We also compared the distance after transforming them to
ultrametric distances by using the UPGMA algorithm to create a rooted
tree. In order to convert this correlation to a distance measure, we
took `1 - correlation(distances)`, so the distance ranged between 0 for
perfect correlation to 2 for perfect negative correlation. A value of 1
represents no correlation whatsoever.

To compare the topology of the phylogenies we calculated the
Robinson-Foulds metric (Robinson and Foulds 1981): a distance measure
for unrooted trees that is defined as the number of partitions of data
implied by the first tree but not the second tree plus the number of
partitions implied by the second tree but not the first tree.

The distances were calculated for all communities in each Community Set
(or sub-set), giving us a large number of replications assessing the
accuracy of each method across random variation in the community
assembly process. For the first pass analysis we used the mean distance
values across all replications within each Community Set, and determined
the top performing metrics. We retained all replicates to assess
variability of accuracy for just those top performing metrics.

Additionally we compared how each of the top performing metrics affected
estimates of phylogenetic distance using the sub-communities we
simulated for each community in the subset of Community Set 1. To test
how well different phylogenetic reconstruction methods reflected the
phylogenetic diversity of communities, as based on the underlying 'true'
phylogeny, we calculated three phylogenetic diversity metrics for each
of these simulated communities, then calculated how different methods
correlated with each other and with phylogenetic diversity calculated
from the 'true' phylogeny. The three metrics are: Mean Phylogenetic
Distance (MPD: Webb 2000), Faith's Phylogenetic Diversity (PD: Faith
1992), and Phylogenetic Species Variance (PSV: Helmus et al. 2007). MPD
is a phylogenetic diversity metric which is based only on a pairwise
phylogenetic distance matrix, and so can be applied to raw genetic
distances, whereas PD and PSV require a phylogenetic tree and so can
only be calculated on the UPGMA and NJ trees generated from the genetic
distances for the alignment-free methods. Additionally, for MPD, we used
a null model analysis to calculate whether communities were
significantly under- or over-dispersed relative to the regional species
pool. This is a common analysis done in phylogenetic ecology, and this
allows us to test whether the phylogenetic analysis method affects the
outcome of this test. For each method we looked at the correlation of
the p-values with those based on the 'true' tree, and also calculated
the proportion of false positives: when the 'true' phylogeny metric was
non-significant (at the alpha=0.05 level), but the metric being compared
was significant, and false negative: when the 'true' phylogeny metric
was significant, but the metric being compared implied a non-significant
effect.

Comparing ecological distance to genetic distances
--------------------------------------------------

Lastly, we compared the above alignment-free metrics and the
alignment-based one, with respect to how well the distances derived from
them predict the ecological distance of real species.

We used the LEDA traits database (Kleyer et al. 2008) for European
plants, which measures a number of ecologically important plant traits,
as well as Ellenberg indicator values (Ellenberg and <span>Leuschner
1151 Ed 6 A198 GEO 2.37.2/104 Ed.6 B552 IPS LEHR 289</span> 2010;
Schaffers and Sýkora 2000), which are a set of scores which rate the
environmental affinities of different species along a number of
environmental axes. For each species that was found in both the LEDA,
and Ellenberg databases, we calculate pairwise distances using Gower
distance (Gower 1971), which can handle different types of data
(continuous and categorical) as well as missing data. This is meant to
reflect the overall ecological distance between every species. In
addition, we calculated this ecological distance with just the LEDA
data, and with just the Ellenberg data for comparison.

For each species that was found in both the LEDA, and Ellenberg
databases, we searched GenBank for available sequences. We found (x)
genes were well represented in the database: (list of genes goes here).
For each genes we calculated pairwise genetic distances for all plant
species for which that gene was available in GenBank, using all of the
methods described above. We then calculated the correlation between all
calculated genetic distances and the ecological distance of those
species. To test significance of these correlations we used Mantel
tests, which account for the lack of independence between pairwise
measurements.

(**Note:** I have not done this section yet, but I think it will add a
lot, e.g. having at least one empirical analysis)

**Results**
===========

Community Set 1:
----------------

### *General Findings*

Using the mean branch-length distances between each of the tested
methods, the method whose branch-lengths were most closely correlated
with the 'true' branch-lengths was the alignment-free metric known as
"K<sub>r</sub>" (Fig 1a). The FFP method with k\>5, FCGR with k\>5 and
BBC with any parameter also produced a fairly accurate distribution of
branch-lengths. Following these alignment-free methods, the
alignment-based methods were the next most accurate.ICPIC and the
graphical based methods were substantially poorer.

The picture was similar for topological accuracy, but FFP and FCGR
methods did slightly better than K<sub>r</sub> (Fig 1b). Again ICPIC and
the graphical methods did poorly.

Overall, UPGMA transformed distances did better than raw distances
(stats go here) in terms of branch-length correlation with the 'true'
phylogeny, and the UPGMA phylogeny produced a more accurate topology
compared with the NJ phylogenies produced from the same genetic
distances.

(**Note:** I want to make a figure showing the actual accuracy values
along with the clustergram (e.g. plot the correlations with the 'true'
phylogeny'))

The effects of gene number, species number, and divergence level were
negligible for all metrics. There were some significant effects but this
was entirely due to the massive sample size---in all cases the
R<sup>2</sup> value was less than 0.01. For all subsequent analyses,
these factors were ignored.

![plot of chunk
Fig1](AFD-manuscript_files/figure-markdown_strict/Fig1.png)

**Figure 1.** *Cluster-grams showing how similarity of phylogenetic
trees constructed using different methods in terms of their
branch-lengths (left panel) and their topology (right panel).
Cluster-grams generated using hierarchical clustering with average
linkage and using the mean distances across all 4000 replications. The
'true' distance or tree is highlighted in red. Methods closest to this
are the most accurate.*

Taking only the best parameter combination of the top metrics (UPGMA
distances for FFP: k=8, RTD: k=7, BBC: k=15, ICPIC: k=150, FCGR: k=6,
K<sub>r</sub>, and K80, plus alignment-based ML phylogenetic distance
and the 'true' phylogenetic distance: all subsequent analyses are
conducted on this set of metrics), we created an ordination plot using
multidimensional scaling to reduce patterns of dissimilarity between the
different metrics into two dimensions (Fig 2).

![plot of chunk
unnamed-chunk-1](AFD-manuscript_files/figure-markdown_strict/unnamed-chunk-11.png)
![plot of chunk
unnamed-chunk-1](AFD-manuscript_files/figure-markdown_strict/unnamed-chunk-12.png)

**Figure 2.** *Ordination plot demonstrating how a sample of different
phylogenetic methods relate to each other in terms of how similar their
estimated branch-lengths (a) or topology (b) are. Colours are the same
in both plots. For each of the 4000 data-sets we used multidimensional
scaling on the branch-length distances to create a set of ordinations in
two dimensions, where each method’s distance to other methods in the two
dimensional space was as close as possible to their measured distance
(a=branch-length correlation distance, b=Robinson-Foulds distance). We
chose an orientation for the first data-set at random and then used a
Procrustes transformation to rotate each data-set’s point-cloud so that
it matched as closely as possible to the first orientation. Ellipses are
based on the multivariate standard error of the clouds.*

Looking at phylogenetic diversity calculated from the different metrics,
the most highly correlated to the "true" phylogenetic diversity was
based on "K<sub>r</sub>", and in general followed a pattern where the
metrics with the most faithful branch-lengths also produced the best
phylogenetic diversity estimates, as we expected (Fig 3). (**Note:** I
have not analyzed the PD or PSV data yet, or the MPD false positives and
false negatives, but I suspect it to show similar results.)

![plot of chunk
Fig3](AFD-manuscript_files/figure-markdown_strict/Fig3.png)

**Figure 3.** *Plot of how well phylogenetic diversity of simulated
local sub-communities calculated with different metrics correlate with
the "True" phylogenetic diversity, based on the underlying 'true'
phylogeny. 1 is a perfect correlation. Points are plotted with a low
opacity so that areas of high density appear black, whereas light grey
are parts of the axis with few data points.*

Community Set 2:
----------------

### *Initial Observations on Taxon Sampling*

Analysis of Community Set 2 showed that to our surprise, increased taxon
sampling had no effect on the accuracy of any of the metrics, including
the alignment-based method. We expected that with increased numbers of
species, the 'gaps' between species in smaller samples would be filled
in, allowing the alignment algorithm to more accurately place gaps. We
suspect that this result is because of limitations in our measurement of
accuracy. For the branch-length correlation, we are correlating the
pairwise distances between all species. As such, with increasing numbers
of species, our sample size is increasing much faster (a factor of
\$\\frac{N(N-1)}{2}\$. This may increase the probability of including
large outliers which might disproportionately effect the correlation.
For the Robinson-Foulds metric we have a similar problem, whereby the
number of possible data partitions grows exponentially with species
richness, such that there is a lot more possible ways for a phylogeny to
be wrong. We wondered if these issues counteracted any gains in
alignment accuracy from more species. To test this, we analyzed
Community Set 3, in which we keep a constant number of 'focal' species
fixed, and added more species only for the calculation of the alignments
and metrics.

Community Set 3:
----------------

### *The Effect of Taxon Sampling*

(**Note:** I have not finished this analysis yet. It is running as you
read... I am hoping it shows what I expect, that more 'peripheral'
species helps make the alignment better, and thus allows a better
estimate of the distances within the focal species, without having to
worry about the total number of datapoints increasing with species).

### *Computation Time*

![plot of chunk
unnamed-chunk-2](AFD-manuscript_files/figure-markdown_strict/unnamed-chunk-2.png)

**Figure 4.** *Computation time of different phylogenetic methods as a
function of the number of species in the analyzed pool. Note the log
scale.*

Comparing ecological distance to genetic distances
--------------------------------------------------

(**Note:** To be filled in when I get the empirical results back.) . . .

**Discussion**
==============

Despite considerable work on the development of alignment free methods
of phylogenetic reconstruction over the past two decades (e.g. Song,
Ren, Reinert, et al. 2013; Cheng, Cao, and Liu 2013; Vinga and Almeida
2003; Song, Ren, Zhai, et al. 2013), the use of alignment followed by
model-based phylogenetic inference is still the most common way to
analyse genetic data. Because of this historic preference for alignment
based methods, ecologists who have had to construct there own
phylogenies for phylogenetic ecological analyses have largely followed
suit. But is there a simpler and faster way that ecologists can produce
phylogenies of comparable usefulness, especially for increasingly
massive ecological data-sets? This study would suggest that there is:
alignment free methods. Here, we showed that many alignment free methods
produce as good, and often better approximations to an underlying 'true'
phylogeny.

In the introduction to this paper, we wrote about how ecologists are
mainly interested in branch-lengths, rather than the topology of
phylogenetic trees, because it is phylogenetic distance which is the
most likely to predict species' differences in their ecology. Here, we
showed that several alignment free methods better reflected phylogenetic
distance than the alignment based method. However, we showed that the
phylogenies generated from hierarchical clustering of alignment free
genetic distances were also more topologically accurate than the
alignment based method. It makes sense that if your branch-lengths are
poorly estimated, this will affect the accuracy of topological
reconstruction, especially if some branch-lengths are very similar. So
we expect branch-length and topological accuracy to be strongly but not
perfectly correlated. If this is the case more generally, then why have
people continued to use alignment based methods? Part of the answer is
that there are surprisingly few studies that actually compare the
performance of alignment based methods with alignment free methods.

When introducing new alignment free methods, studies usually test the
performance of them using simulation. However, most of these studies use
an alignment based method as the baseline. They conclude that if their
alignment free method correlates well with the alignment based method
then it is a good method. However, this assumes the alignment based
method is reflecting the underlying 'true' phylogeny well, if not, then
being less correlated with it could in fact be considered a good thing.
A review of several alignment free methods (Höhl and Ragan 2007)
compared the alignment free based phylogenies to a maximum likelihood
phylogeny estimated using the known 'true' alignment, and concluded they
did relatively poorly. This is clearly not a fair comparison, as the
alignment part of the alignment based method was not undertaken. Another
review that properly tested several alignment based methods against a
full alignment based method---in this case model-based distance without
phylogenetic reconstruction (Yang and Zhang 2008)---by comparing the
result to a known underlying phylogeny, concluded, similarly to this
study, that alignment-free methods were more accurate most of the time.
The fact is that most studies assume that alignment is the best way to
go, because of a bias towards a particular philosophy of phylogenetic
reconstruction: that it should be based on an evolutionary model.

The main reason that alignment based methods are the method of choice is
because of the post-alignment step, which is explicitly model based.
There is a strong desire to couch a phylogenetic hypothesis in a
modeling framework, allowing the possibility of discussing the merits of
alternative models, and allowing better expression of uncertainty.
Indeed, this is a solid argument for modeling approaches, but until
recently these modeling approaches all required an initial step, which
usually does not involve a model of evolution: sequence alignment (or
homology estimation). Sequence alignment algorithms are generally
heuristic methods rather than an explicit model of any process,
introducing some arbitrariness into the overall approach. Indeed most
evolutionary models of sequence evolution assume that the input
alignment is the true alignment. This is probably why there has been an
increasing interest in simultaneously modeling alignment and
phylogenetic inference, with some recent progress (refs). This is a
promising area, however, these techniques at the moment are very
time-consuming, especially for large data-sets. Since most systematists
study single small taxonomic groups in individual studies, the amount of
divergence is small, and the issues with accurate alignment are
consequently also small. But modelling sequence evolution allows
systematists to get the information they want. In this study we have
modeled much greater evolutionary divergence and levels of taxon
sampling than usually seen in most systematic studies, but which are
frequently encountered by ecologists.

Modelling evolution is most important when trying to distinguish the
order of branching of organisms that have fairly similar branch-lengths
between them. When branch-lengths vary greatly, it is simple to find
which organisms groups together and how they nest within different
groups. Combined with other considerations---chiefly choosing an
appropriate outgroup---we can use a phylogenetic topology to infer past
evolutionary events. Systematists in particular are interested in
getting this right, and especially for those more ambiguous groups which
are all similarly related to each other. On the other hand, for
ecologists, knowing which of a group of similarly related organisms fall
into the same natural grouping is of much less relevance. Regardless of
which groups diverged first, if they have similar branch-lengths between
them, they are expected to have a similar degree of ecological
divergence. For ecologists, getting the overall pattern of
branch-lengths correct should be the first priority. Based on the
results of this study, we would recommend using an alignment free method
for ecological studies, particularly the metric introduced by Haubold et
al. (2009): K<sub>r</sub>, which outperformed the other metrics, and has
a number of other benefits as well.

K<sub>r</sub> is the only alignment free method tested here to be based
on an evolutionary model, which is perhaps why it is as accurate as it
is. The evolutionary model allows K<sub>r</sub> to be an estimate of a
quantity that diverges linearly with time, meaning it should reflect
time since divergence well. Most other metrics are known to
theoretically diverge with increasing sequence divergence, but there is
no guarantee that this divergence is linear with respect to the
evolutionary processes generating the differences, namely base-pair
substitutions occurring at a particular rate through time. Indeed, most
alignment free distance metrics diverge rapidly with initial
evolutionary change in a sequence but then rapidly saturate as these
changes become greater [Haubold et al. (2009), Fig 5 **Note:** Have not
made this figure yet). This may explain why the FFP method outperformed
the K<sub>r</sub> method in accurately reconstructing the topology but
not the branch-lengths of the 'true' phylogeny. The rapid divergence of
FFP may have exaggerated the rank difference in small branches leading
to better grouping of species near the tips. Since there are far more
possible data partitions at the tips of trees, this contributes to the
Robinson-Foulds distance more, than larger branch-lengths, where the
saturation starts to occur. On the other hand, K<sub>r</sub> is better
at representing branch-lengths at all levels of divergence better.

A way of dealing with the saturation issue of many k-mer based
alignment-free metrics has recently been proposed, whereby k-mer based
distance are adjusted in a taxon specific way using machine learning
techniques (ref). However, the adjustments are trained on subset of
'known' distances, which are based on a sequence alignment. This is
useful if we want our alignment free methods to produce an answer as
similar as possible to the answer using alignment, for consistency, even
if we know the alignment based method may not be the best approximation
of the truth.

K<sub>r</sub> has an additional advantage over some of the other methods
in that it has no parameters. K-mer based methods, on the other hand,
require choosing a value for the word length K, and it is not always
clear a priori which is the best. Most studies have concluded that a
value of K somewhere between 6 and 12 works well (refs), and this study
supports that as well. K<sub>r</sub> is also potentially extendable,
since it is model based. More complex models could be incorporated into
its calculation, uncertainty could be incorporated, or its basic
modelling principles could be incorporated into a full evolutionary
model taking place across a tree instead of just a single pairwise
pathway, allowing full phylogenetic estimation in one go without
alignment. The authors point out that K<sub>r</sub> becomes less stable
and upwardly biased when the average number of substitutions per site
become greater than about 0.6. In our study we show that this issue
causes no worse a problem for correlation with the true branch-lengths
than it does for the alignment based method used here.

Overall, this study does not support the wholesale replacement of
alignment based techniques by alignment free methods. We only looked at
one combination of alignment based techniques; others might perform
better. However, we used a combination of alignment based methods likely
to be used in situations with large data-sets, because of their
relatively rapid execution times. There are many other alignment methods
besides MUSCLE which may work better in our situation, and also many
other methods for constructing phylogenies, once an alignment is
obtained, besides RAxML, such as Bayesian methods and other slower
maximum likelihood algorithms. (I think we are going to have to look at
some more alignment based methods before we publish this, I don't think
reviewers are going to buy this. Easily doable but will take some time
given the slowness of alignment based methods. My suggestion is that I
use a smaller subset of the replications to run other alignment based
combos on, just to show they are (hopefully) consistent with the main
result). Even if there exists an alignment free method that will on
average exceed the accuracy of the alignment-free methods, there will
still be a strong incentive to use the alignment-free methods when
data-sets are large, simply due to the massive saving in required
computational resources.

-   Talk about relevance to ecology more specifically
-   Phylogenetic ecology is based on several levels of approximation in
    any case
-   Traits should not be expected to correlate exactly with phylogeny in
    any case
-   Genetic distance are fine for ecology, except in a few rare cases
    -   when should topology matter in ecology?

Figures
=======

**References**
==============

Ackerly, D D, and W K Cornwell. 2007. “A Trait-Based Approach to
Community Assembly: partitioning of Species Trait Values into Within-
and Among-Community Components.” *Ecology Letters* 10 (2): 135–145.
doi:[10.1111/j.1461-0248.2006.01006.x](http://dx.doi.org/10.1111/j.1461-0248.2006.01006.x).

Cadotte, Marc W, T <span>Jonathan Davies</span>, James Regetz, Steven W
Kembel, Elsa Cleland, and Todd H Oakley. 2010. “Phylogenetic Diversity
Metrics for Ecological Communities: integrating Species Richness,
Abundance and Evolutionary History.” *Ecology Letters* 13 (1): 96–105.
doi:[10.1111/j.1461-0248.2009.01405.x](http://dx.doi.org/10.1111/j.1461-0248.2009.01405.x).
<http://www.ncbi.nlm.nih.gov/pubmed/19903196>.

Cadotte, Marc, Cecile H Albert, and Steve C Walker. 2013. “The Ecology
of Differences: assessing Community Assembly with Trait and Evolutionary
Distances.” *Ecology Letters*: 1234–1244.
doi:[10.1111/ele.12161](http://dx.doi.org/10.1111/ele.12161).
<http://www.ncbi.nlm.nih.gov/pubmed/23910526>.

Cavender-Bares, Jeannine, K.H. Kozak, P.V.A. Fine, and S.W. Kembel.
2009. “The Merging of Community Ecology and Phylogenetic Biology.”
*Ecology Letters* 12 (7): 693–715.
<http://www3.interscience.wiley.com/journal/122388144/abstract>.

Cheng, Jinkui, Fuliang Cao, and Zhihua Liu. 2013. “AGP: a Multimethods
Web Server for Alignment-Free Genome Phylogeny.” *Molecular Biology and
Evolution* 30 (5): 1032–7.
<http://www.ncbi.nlm.nih.gov/pubmed/23389766>.

Dalquen, Daniel a, Maria Anisimova, Gaston H Gonnet, and Christophe
Dessimoz. 2012. “ALF–a Simulation Framework for Genome Evolution.”
*Molecular Biology and Evolution* 29 (4): 1115–23.
doi:[10.1093/molbev/msr268](http://dx.doi.org/10.1093/molbev/msr268).
[http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=3341827\\&tool=pmcentrez\\&rendertype=abstract](http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=3341827\&tool=pmcentrez\&rendertype=abstract).

Dayhoff, MO, RM Schwartz, and BC Orcutt. 1978. “A Model of Evolutionary
Change in Proteins.” In *Atlas of Protein Sequence and Structure*,
edited by M O Dayhoff, 345–352. National Biomedical Research Foundation.
<http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.145.4315>.

Deng, Mo, Chenglong Yu, Qian Liang, Rong L. He, and Stephen S T Yau.
2011. “A Novel Method of Characterizing Genetic Sequences: Genome Space
with Biological Distance and Applications.” *PLoS ONE* 6 (3).

Edgar, Robert C. 2004. “MUSCLE: multiple Sequence Alignment with High
Accuracy and High Throughput.” *Nucl. Acids Res.* 32 (5): 1792–7.
doi:[10.1093/nar/gkh340](http://dx.doi.org/10.1093/nar/gkh340).
[http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=390337\\&tool=pmcentrez\\&rendertype=abstract](http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=390337\&tool=pmcentrez\&rendertype=abstract).

Ellenberg, Heinz, and Christoph C N - A255 IPNA 3507 A100 Lesesaal 191
<span>Leuschner 1151 Ed 6 A198 GEO 2.37.2/104 Ed.6 B552 IPS LEHR
289</span>. 2010. *Vegetation Mitteleuropas Mit Den Alpen in
Ökologischer, Dynamischer Und Historischer Sicht*.

Faith, Daniel P. 1992. “Conservation Evaluation and Phylogenetic
Diversity.” *Biological Conservation* 61 (1) (January): 1–10.
doi:[10.1016/0006-3207(92)91201-3](http://dx.doi.org/10.1016/0006-3207(92)91201-3).
<http://linkinghub.elsevier.com/retrieve/pii/0006320792912013>.

Flynn, Dan F B, Nicholas Mirotchnick, Meha Jain, Matthew I Palmer, and
Shahid Naeem. 2011. “Functional and Phylogenetic Diversity as Predictors
of Biodiversity–Ecosystem-Function Relationships.” *Ecology* 92 (8)
(August): 1573–81. <http://www.ncbi.nlm.nih.gov/pubmed/21905424>.

Gao, Yang, and Liaofu Luo. 2012. “Genome-Based Phylogeny of DsDNA
Viruses by a Novel Alignment-Free Method.” *Gene* 492 (1): 309–314.

Gower, J C. 1971. “A General Coefficient of Similarity and Some of Its
Properties.” *Biometrics* 27 (4): 857–871.
doi:[10.2307/2528823](http://dx.doi.org/10.2307/2528823).
<http://www.jstor.org/stable/2528823>.

Hardy, Olivier J., and Bruno Senterre. 2007. “Characterizing the
Phylogenetic Structure of Communities by an Additive Partitioning of
Phylogenetic Diversity.” *Journal of Ecology* 95 (3) (May): 493–506.
doi:[10.1111/j.1365-2745.2007.01222.x](http://dx.doi.org/10.1111/j.1365-2745.2007.01222.x).
<http://doi.wiley.com/10.1111/j.1365-2745.2007.01222.x>.

Hatje, Klas, and Martin Kollmar. 2012. “A Phylogenetic Analysis of the
Brassicales Clade Based on an Alignment-Free Sequence Comparison
Method.” *Frontiers in Plant Science*.

Haubold, Bernhard, Peter Pfaffelhuber, Mirjana Domazet-Loso, and Thomas
Wiehe. 2009. “Estimating Mutation Distances from Unaligned Genomes.”
*Journal of Computational Biology : a Journal of Computational Molecular
Cell Biology* 16 (10) (October): 1487–500.
doi:[10.1089/cmb.2009.0106](http://dx.doi.org/10.1089/cmb.2009.0106).
<http://www.ncbi.nlm.nih.gov/pubmed/19803738>.

Hein, J, C Wiuf, B Knudsen, M B Møller, and G Wibling. 2000.
“Statistical Alignment: computational Properties, Homology Testing and
Goodness-of-Fit.” *Journal of Molecular Biology* 302 (1): 265–279.

Helmus, Matthew R, Thomas J Bland, Christopher K Williams, and Anthony R
Ives. 2007. “Phylogenetic Measures of Biodiversity.” *The American
Naturalist* 169 (3) (January).
doi:[10.1086/511334](http://dx.doi.org/10.1086/511334).
<http://www.ncbi.nlm.nih.gov/pubmed/17230400>.

Höhl, Michael, and Mark A Ragan. 2007. “Is Multiple-Sequence Alignment
Required for Accurate Inference of Phylogeny?” *Systematic Biology* 56
(2): 206–221.
doi:[10.1080/10635150701294741](http://dx.doi.org/10.1080/10635150701294741).

Huang, Guohua, Houqing Zhou, Yongfan Li, and Lixin Xu. 2011.
“Alignment-Free Comparison of Genome Sequences by a New Numerical
Characterization.” *Journal of Theoretical Biology* 281 (1): 107–112.

Jun, Se-Ran, Gregory E Sims, Guohong A Wu, and Sung-Hou Kim. 2010.
“Whole-Proteome Phylogeny of Prokaryotes by Feature Frequency Profiles:
An Alignment-Free Method with Optimal Feature Resolution.” *Proceedings
of the National Academy of Sciences of the United States of America* 107
(1) (January): 133–8.
doi:[10.1073/pnas.0913033107](http://dx.doi.org/10.1073/pnas.0913033107).
[http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=2806744\\&tool=pmcentrez\\&rendertype=abstract](http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=2806744\&tool=pmcentrez\&rendertype=abstract).

Kimura, M. 1980. “A Simple Method for Estimating Evolutionary Rates of
Base Substitutions Through Comparative Studies of Nucleotide Sequences.”
*Journal of Molecular Evolution* 16 (2): 111–120.

Kleyer, M, R M Bekker, I C Knevel, J P Bakker, K Thompson, M
Sonnenschein, P Poschlod, et al. 2008. “The LEDA Traitbase: a Database
of Life-History Traits of the Northwest European Flora.” *Journal of
Ecology* 96 (6): 1266–1274.
doi:[10.1111/j.1365-2745.2008.01430.x](http://dx.doi.org/10.1111/j.1365-2745.2008.01430.x).
<http://blackwell-synergy.com/doi/abs/10.1111/j.1365-2745.2008.01430.x>.

Kolekar, Pandurang, Mohan Kale, and Urmila Kulkarni-Kale. 2012.
“Alignment-Free Distance Measure Based on Return Time Distribution for
Sequence Analysis: Applications to Clustering, Molecular Phylogeny and
Subtyping.” *Molecular Phylogenetics and Evolution* 65 (2): 510–522.

Kraft, Nathan J B, William K Cornwell, Campbell O Webb, and David D
Ackerly. 2007. “Trait Evolution, Community Assembly, and the
Phylogenetic Structure of Ecological Communities.” *The American
Naturalist* 170 (2): 271–83.
doi:[10.1086/519400](http://dx.doi.org/10.1086/519400).
<http://www.ncbi.nlm.nih.gov/pubmed/17874377>.

Liu, Zhi-Hua, and Xiao Sun. 2008. “Coronavirus Phylogeny Based on
Base-Base Correlation.” *International Journal of Bioinformatics
Research and Applications* 4 (2): 211–220.
doi:[10.1504/IJBRA.2008.018347](http://dx.doi.org/10.1504/IJBRA.2008.018347).

Lunter, Gerton, Andrea Rocco, Naila Mimouni, Andreas Heger, Alexandre
Caldeira, and Jotun Hein. 2008. “Uncertainty in Homology Inferences:
assessing and Improving Genomic Sequence Alignment.” *Genome Research*
18 (2): 298–309.

McGill, BJ, BJ Enquist, E Weiher, and M Westoby. 2006. “Rebuilding
Community Ecology from Functional Traits.” *Trends in Ecology & …*.
<http://www.sciencedirect.com/science/article/pii/S0169534706000334>.

Messier, Julie, Brian J McGill, and Martin J Lechowicz. 2010. “How Do
Traits Vary Across Ecological Scales? A Case for Trait-Based Ecology.”
*Ecology Letters* 13 (7): 838–848.
doi:[10.1111/j.1461-0248.2010.01476.x](http://dx.doi.org/10.1111/j.1461-0248.2010.01476.x).

Morgan, Matthew J., and Scot A. Kelchner. 2010. “Inference of Molecular
Homology and Sequence Alignment by Direct Optimization.” *Molecular
Phylogenetics and Evolution* 56 (1): 305–311.

Müllner, Daniel. 2013. “fastcluster: Fast Hierarchical, Agglomerative
Clustering Routines for R and Python.” *Journal of Statistical Software*
53 (9): 1–18.

Paradis, Emmanuel, Julien Claude, and Korbinian Strimmer. 2004. “APE:
Analyses of Phylogenetics and Evolution in R Language.” *Bioinformatics
(Oxford, England)* 20 (2): 289–290.

Phillips, Aloysius J. 2006. “Homology Assessment and Molecular Sequence
Alignment.” *Journal of Biomedical Informatics*.

Price, Morgan N., Paramvir S. Dehal, and Adam P. Arkin. 2010. “FastTree
2 - Approximately Maximum-Likelihood Trees for Large Alignments.” *PLoS
ONE* 5 (3).

R Development Core Team. 2010. “R: A Language and Environment for
Statistical Computing.” Edited by R Development Core Team. *R Foundation
for Statistical Computing*. R Foundation for Statistical Computing; R
Foundation for Statistical Computing.
doi:[ISBN 3-900051-00-3](http://dx.doi.org/ISBN 3-900051-00-3).
<http://www.r-project.org>.

Robinson, D. F., and L. R. Foulds. 1981. “Comparison of Phylogenetic
Trees.” *Mathematical Biosciences*.

Sanderson, Michael J. 2002. “Estimating Absolute Rates of Molecular
Evolution and Divergence Times: a Penalized Likelihood Approach.”
*Molecular Biology and Evolution* 19 (1): 101–109.

Schaffers, André P, and Karlè V Sýkora. 2000. “Reliability of Ellenberg
Indicator Values for Moisture, Nitrogen and Soil Reaction: A Comparison
with Field Measurements.” *Journal of Vegetation Science* 11 (2):
225–244. doi:[10.2307/3236802](http://dx.doi.org/10.2307/3236802).
<http://www.jstor.org/stable/3236802>.

Sneath, P H A, and R R Sokal. 1973. *Numerical Taxonomy: The Principles
and Practice of Numerical Classification*.
<http://www.cabdirect.org/abstracts/19730310919.html>.

Sokal, R R. 1986. “Phenetic Taxonomy: Theory and Methods.” *Annual
Review of Ecology and Systematics*.
doi:[10.1146/annurev.es.17.110186.002231](http://dx.doi.org/10.1146/annurev.es.17.110186.002231).

Song, Kai, Jie Ren, Gesine Reinert, Minghua Deng, Michael S Waterman,
and Fengzhu Sun. 2013. “New Developments of Alignment-Free Sequence
Comparison: measures, Statistics and Next-Generation Sequencing.”
*Briefings in Bioinformatics*.
doi:[10.1093/bib/bbt067](http://dx.doi.org/10.1093/bib/bbt067).
<http://www.ncbi.nlm.nih.gov/pubmed/24064230>.

Song, Kai, Jie Ren, Zhiyuan Zhai, Xuemei Liu, Minghua Deng, and Fengzhu
Sun. 2013. “Alignment-Free Sequence Comparison Based on Next-Generation
Sequencing Reads.” *Journal of Computational Biology : a Journal of
Computational Molecular Cell Biology* 20 (2) (February): 64–79.
doi:[10.1089/cmb.2012.0228](http://dx.doi.org/10.1089/cmb.2012.0228).
[http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=3581251\\&tool=pmcentrez\\&rendertype=abstract](http://www.pubmedcentral.nih.gov/articlerender.fcgi?artid=3581251\&tool=pmcentrez\&rendertype=abstract).

Stamatakis, A. 2014. “RAxML Version 8: a Tool for Phylogenetic Analysis
and Post-Analysis of Large Phylogenies.” *Bioinformatics*: open access.
doi:[10.1093/bioinformatics/btu033](http://dx.doi.org/10.1093/bioinformatics/btu033).
<http://www.ncbi.nlm.nih.gov/pubmed/24451623>.

Vinga, S., and J. Almeida. 2003. “Alignment-Free Sequence Comparison–a
Review.” *Bioinformatics* 19 (4) (March): 513–523.
doi:[10.1093/bioinformatics/btg005](http://dx.doi.org/10.1093/bioinformatics/btg005).
<http://bioinformatics.oxfordjournals.org/cgi/doi/10.1093/bioinformatics/btg005>.

Violle, C., and L. Jiang. 2009. “Towards a Trait-Based Quantification of
Species Niche.” *Journal of Plant Ecology* 2 (2): 87–93.
doi:[10.1093/jpe/rtp007](http://dx.doi.org/10.1093/jpe/rtp007).
[http://jpe.oxfordjournals.org/cgi/doi/10.1093/jpe/rtp007\$\\backslash\$nhttp://jpe.oxfordjournals.org/content/2/2/87.full](http://jpe.oxfordjournals.org/cgi/doi/10.1093/jpe/rtp007$\backslash$nhttp://jpe.oxfordjournals.org/content/2/2/87.full).

Webb, Campbell O., David D Ackerly, Mark a. McPeek, and Michael J.
Donoghue. 2002. “Phylogenies and Community Ecology.” *Annual Review of
Ecology and Systematics* 33 (1) (November): 475–505.
doi:[10.1146/annurev.ecolsys.33.010802.150448](http://dx.doi.org/10.1146/annurev.ecolsys.33.010802.150448).
<http://arjournals.annualreviews.org/doi/abs/10.1146/annurev.ecolsys.33.010802.150448>.

Webb, CO. 2000. “Exploring the Phylogenetic Structure of Ecological
Communities: An Example for Rain Forest Trees.” *The American
Naturalist* 156 (2) (August): 145–155.
doi:[10.1086/303378](http://dx.doi.org/10.1086/303378).
<http://www.jstor.org/stable/10.1086/303378>.

Webb, Colleen T, Jennifer A Hoeting, Gregory M Ames, Matthew I Pyne, and
N <span>LeRoy Poff</span>. 2010. “A Structured and Dynamic Framework to
Advance Traits-Based Theory and Prediction in Ecology.” *Ecology
Letters* 13 (3): 267–283.
doi:[10.1111/j.1461-0248.2010.01444.x](http://dx.doi.org/10.1111/j.1461-0248.2010.01444.x).

Wiens, J.J., D.D. Ackerly, A.P. Allen, B.L. Anacker, L.B. Buckley,
Howard V Cornell, E.I. Damschen, T. <span>Jonathan Davies</span>, J.A.
Grytnes, and S.P. Harrison. 2010. “Niche Conservatism as an Emerging
Principle in Ecology and Conservation Biology.” *Ecology Letters* 13
(10) (July): 1310–1324.
doi:[10.1111/j.1461-0248.2010.01515.x](http://dx.doi.org/10.1111/j.1461-0248.2010.01515.x).
<http://onlinelibrary.wiley.com/doi/10.1111/j.1461-0248.2010.01515.x/full>.

Winter, M, V Devictor, and O Schweiger. 2012. “Phylogenetic Diversity
and Nature Conservation: where Are We?” *Trends in Ecology & Evolution*.
<http://www.sciencedirect.com/science/article/pii/S0169534712002881>.

Yang, Kuan, and Liqing Zhang. 2008. “Performance Comparison Between
K-Tuple Distance and Four Model-Based Distances in Phylogenetic Tree
Reconstruction.” *Nucleic Acids Research* 36 (5): e33.

Yu, Chenglong, Qian Liang, Changchuan Yin, Rong L He, and Stephen S-T
Yau. 2010. “A Novel Construction of Genome Space with Biological
Geometry.” *DNA Research : an International Journal for Rapid
Publication of Reports on Genes and Genomes* 17 (3): 155–168.
