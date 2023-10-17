# install a env and register with jupyter
mamba create -n omics423 -c conda-forge r-base==4.2.3 r-rjags

mamba activate omics423

# - install the kernel
# - need explicitly add base R version it to be maintained.
# - install several packages from conda forge, and others from biocondas
# - bioc
# - install hdf5 for MOVICS etc
# - variants
# - clustering
# - single cell: install LAST lots of dependencies
mamba install -y -c conda-forge r-base==4.2.3 \
    r-rjags r-conflicted r-tidyverse \
    r-remotes r-devtools r-pacman r-janitor r-RcppTOML r-tidylog \
    r-recommended r-irkernel ipython r-hdf5r r-params r-flowr \
    r-bedr r-rmarkdown r-rcpp r-pillar r-readr \
    r-conflicted r-tidyverse r-remotes r-devtools r-pacman r-janitor r-RcppTOML r-tidylog \
    r-nmf r-snftool r-Rcpp r-pracma r-RcppAnnoy r-RSpectra r-glmnet r-bigmemory \
    r-ggstatsplot r-ggalluvial r-ggpubr r-wesanderson r-rcartocolor \
    r-biocmanager \
    -c bioconda bioconductor-complexheatmap bioconductor-GSVA bioconductor-maftools r-openxlsx \
    bioconductor-rhdf5lib bioconductor-HDF5Array bioconductor-geoquery \
    bioconductor-enrichplot bioconductor-consensusclusterplus bioconductor-deseq2 bioconductor-edger \
    bioconductor-variantannotation r-vcfr \
    bioconductor-clusterprofiler r-classdiscovery bioconductor-iclusterplus \
    -c conda-forge r-seurat
    
# this cant be installed
mamba install -y -c r r-base==4.2.3 \
    r-synchronicity r-dbx r-pins


# now within R
R

# .libPaths("/home/seths3/apps/mambaforge/envs/omics423/lib/R/library")
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
/home/sseth/apps/mambaforge/envs/omics423/bin/R -e 'IRkernel::installspec(name = "R423omics", displayname = "R 4.2.3 omics")'
"""

