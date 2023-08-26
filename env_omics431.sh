# install a env and register with jupyter
mamba create -n omics431 -c conda-forge r-base==4.3.1 r-rjags

mamba activate omics431

# install the kernel
mamba install -y r-recommended r-irkernel ipython

# jupyter client
mamba install -y jupyter

#conda install -c bioconda bioconda-scater
mamba install -y -c conda-forge r-hdf5r r-params r-flowr r-bedr r-rmarkdown r-rcpp r-pillar r-readr

# tidyverse etc
mamba install -y -c conda-forge r-conflicted r-tidyverse r-remotes r-devtools r-pacman r-janitor r-RcppTOML r-tidylog
# cran clustering
mamba install -y -c conda-forge r-nmf r-snftool r-Rcpp r-pracma r-RcppAnnoy r-RSpectra r-glmnet r-bigmemory

# paralleization etc
mamba install -y -c r r-synchronicity

# plotting
mamba install -y -c conda-forge r-ggstatsplot r-ggalluvial r-ggpubr r-wesanderson r-rcartocolor

# bioc
mamba install -y -c bioconda bioconductor-complexheatmap bioconductor-GSVA bioconductor-maftools r-openxlsx

# install hdf5 for MOVICS etc
mamba install -y -c bioconda bioconductor-rhdf5lib bioconductor-HDF5Array bioconductor-geoquery
mamba install -y -c bioconda bioconductor-enrichplot bioconductor-consensusclusterplus bioconductor-deseq2 bioconductor-edger 

# bioc variants
mamba install -y -c bioconda bioconductor-variantannotation  r-vcfr

# clustering
mamba install -y -c bioconda bioconductor-clusterprofiler r-classdiscovery bioconductor-iclusterplus bioconductor-treeio bioconductor-ggtree bioconductor-genefu

# DB
mamba install -y -c r r-pins
# r-dbx

# single cell
mamba install -y -c bioconda r-seurat

# clusterProfiler, flexclust, aricode, ggpp, survminer, vegan, mogsa, iClusterPlus, coca, PINSPlus, IntNMF, ClassDiscovery
# waldo, pkgload, desc, testthat, gmodels, survey, gridtext, modeltools, kernlab, robustbase, diptest, prabclus, flexmix, mclust, genefilter, coxme, geepack, gson, downloader, xts, ggtext, survMisc, maxstat, permute, svd, corpcor, gplots, graphite, sparcl, pheatmap, glmnet, impute, FNN, RcppParallel, entropy, InterSIM, oompaData, clusterRepro, pamr, sva, ridge, preprocessCore, jstable, clusterProfiler, flexclust, aricode, ggpp, survminer, vegan, mogsa, iClusterPlus, coca, PINSPlus, IntNMF, ClassDiscovery

# now within R
R
# source("/home/seths3/dotfiles/R/install_packages.R")
# if (!requireNamespace("remotes", quietly = TRUE)) {
#   install.packages("remotes")
# }

# .libPaths("/home/seths3/apps/mambaforge/envs/omics431/lib/R/library")
#BiocManager::install(c("PINSPlus", "coca"))
# install major packages
# installed the latest version of all packages
remotes::install_github("sahilseth/wranglr")
remotes::install_github("sahilseth/params")
remotes::install_github("xlucpu/MOVICS")

# conda version does not work
install.packages("synchronicity")
p_install(dbx)
remotes::install_github("edgararuiz/connections")


"""
# register the client
# register R kernel with jupyter client
/home/seths3/apps/mambaforge/envs/omics431/bin/R -e 'IRkernel::installspec(name = "R431omics", displayname = "R 4.3.1 omics")'
"""


# mamba deactivate
# register with jupyter
# https://stackoverflow.com/questions/28831854/how-do-i-add-python3-kernel-to-jupyter-ipython
# ipython kernel install --user --name omics-R431
# Installed kernelspec omics-R431 in /home/seths3/.local/share/jupyter/kernels/omics-r431
# python -m ipykernel install --name omics431

# start rstudio:
# /home/seths3/projects_pub/rocker/scripts/rstudio_mamba.sh
