 install a env and register with jupyter
mamba create -n omics431 -c conda-forge r-base==4.3.1 r-rjags

mamba activate omics431

# install the kernel
# jupyter client
# tidyverse etc
# cran clustering
# plotting
mamba install -y -c conda-forge r-recommended r-irkernel ipython \
    jupyter \
    r-base==4.3.1 r-rjags \
    r-hdf5r r-params r-flowr r-bedr r-rmarkdown r-rcpp r-pillar r-readr r-effsize \
    r-conflicted r-tidyverse r-remotes r-devtools r-pacman r-janitor r-RcppTOML r-tidylog \
    r-nmf r-snftool r-Rcpp r-pracma r-RcppAnnoy r-RSpectra r-glmnet r-bigmemory \
    r-ggstatsplot r-ggalluvial r-ggpubr r-wesanderson r-rcartocolor r-circlize \
    r-biocmanager r-getpass r-yarrr \
    r-tidymodels r-recipes r-workflows r-workflowsets r-parameters r-broom r-formula.tools \
    r-survminer r-params

mamba install -y -c r r-base==4.3.1 r-openintro

# bioc
# bioc variants
# clustering
#-c conda-forge r-base==4.3.1 r-rjags \
mamba install -y -c bioconda r-base==4.3.1 \
    bioconductor-biocversion \
    bioconductor-complexheatmap bioconductor-GSVA bioconductor-maftools r-openxlsx \
    bioconductor-multiassayexperiment \
    bioconductor-rhdf5lib bioconductor-HDF5Array bioconductor-geoquery \
    bioconductor-enrichplot bioconductor-consensusclusterplus bioconductor-deseq2 bioconductor-edger \
    bioconductor-variantannotation r-vcfr bioconductor-iranges bioconductor-plyranges \
    bioconductor-clusterprofiler r-classdiscovery bioconductor-iclusterplus bioconductor-treeio \
    bioconductor-ggtree bioconductor-genefu \
    bioconductor-cbioportaldata bioconductor-shortread \
    r-seurat bioconductor-plyranges

# DB this is also scary, dont use R channel
mamba install -c r r-base==4.3.1 \
    r-synchronicity r-dbx r-pins
# this cant be installed



# now within R
# .libPaths("/home/seths3/apps/mambaforge/envs/omics431/lib/R/library")
# install major packages
BiocManager::install(c("PINSPlus", "coca"))
remotes::install_github("sahilseth/wranglr")
remotes::install_github("sahilseth/params")
remotes::install_github("xlucpu/MOVICS")
remotes::install_local("projects_git/my.ultraseq/my.ultraseq")
devtools::install("~/projects/packs_cancergenes")


# conda version does not work
install.packages("synchronicity")
p_install(dbx)
p_install(pins)
remotes::install_github("edgararuiz/connections")

remotes::install_github("ebecht/MCPcounter",ref="master", subdir = "Source")



"""
# https://stackoverflow.com/questions/28831854/how-do-i-add-python3-kernel-to-jupyter-ipython
# register the client
# register R kernel with jupyter client
/home/sseth/apps/mambaforge/envs/omics431/bin/R -e 'IRkernel::installspec(name = "R431omics", displayname = "R 4.3.1 omics")'
"""