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

#mamba install -y -c conda-forge r-base==4.3.1 r-rjags
# paralleization etc
# this install R 4.2.3!! this is scary!
#mamba install -y -c r r-synchronicity

# plotting
mamba install -y -c conda-forge r-ggstatsplot r-ggalluvial r-ggpubr r-wesanderson r-rcartocolor

# bioc
mamba install -y -c bioconda bioconductor-complexheatmap bioconductor-GSVA bioconductor-maftools r-openxlsx

# install hdf5 for MOVICS etc
mamba install -y -c bioconda bioconductor-rhdf5lib bioconductor-HDF5Array bioconductor-geoquery
mamba install -y -c bioconda bioconductor-enrichplot bioconductor-consensusclusterplus bioconductor-deseq2 bioconductor-edger 

# bioc variants
mamba install -y -c bioconda bioconductor-variantannotation r-vcfr

# clustering
mamba install -y -c bioconda bioconductor-clusterprofiler r-classdiscovery bioconductor-iclusterplus bioconductor-treeio bioconductor-ggtree bioconductor-genefu

# DB this is also scary, dont use R channel
# mamba install -y -c r r-pins
# r-dbx

# single cell
mamba install -y -c bioconda r-seurat


# now within R
R

# .libPaths("/home/seths3/apps/mambaforge/envs/omics431/lib/R/library")
BiocManager::install(c("PINSPlus", "coca"))
# install major packages
remotes::install_github("sahilseth/wranglr")
remotes::install_github("sahilseth/params")
remotes::install_github("xlucpu/MOVICS")

# conda version does not work
install.packages("synchronicity")
p_install(dbx)
p_install(pins)
remotes::install_github("edgararuiz/connections")


"""
# https://stackoverflow.com/questions/28831854/how-do-i-add-python3-kernel-to-jupyter-ipython
# register the client
# register R kernel with jupyter client
/home/sseth/apps/mambaforge/envs/omics431/bin/R -e 'IRkernel::installspec(name = "R431omics", displayname = "R 4.3.1 omics")'
"""