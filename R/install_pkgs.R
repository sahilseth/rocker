

# updating current list of packages
# https://www.osc.edu/resources/getting_started/howto/howto_install_local_r_packages

# ubuntu pks:
#sudo apt-get install libmpfr-dev
#sudo apt-get install libgmp3-dev

# mac install:
# brew install libxml2

# source("~/Dropbox/misc/Rinstall_pkgs.R")

# optional step requires permissions
# upgrade(packageStatus(), ask=F) # add sseth to root grp

# remove ALL modules, to prevent issues, especially CUDA
# module rm R cuda conda
#.libPaths("/home/sseth/R/x86_64-pc-linux-gnu-library/3.5_openblas")

# OR
#update.packages(ask=F)
# updating all pkgs in personal libpath
update.packages(ask=F, lib.loc = .libPaths()[1])

# updating all bioconductor pkgs
install.packages("BiocManager")

# ** maintaining a list of packages in:**

# get a list of pkgs
# pkgs = unlist(read.table("~/tmp/Rpkgs.txt",  stringsAsFactors = FALSE))
pkgs = unlist(read.table("~/dotfiles/R/Rpkgs.txt",  stringsAsFactors = FALSE))

# make this the first
#.libPaths("/rsrch3/home/iacs/sseth/R/x86_64-pc-linux-gnu-library/3.6")
#.libPaths("/rsrch3/home/iacs/sseth/R/x86_64-pc-linux-gnu-library/4.0")


# idea1 (works)
install_my_pkgs <- function(){
  ins = installed.packages()[, 1]
  need_pkgs = pkgs[which(is.na(match(pkgs, ins)))]
  length(need_pkgs)
  need_pkgs

  for(pkg in need_pkgs){
    # does not re-install uneccesarily
    need_pkgs = pkgs[which(is.na(match(pkgs, ins)))]

    message(pkg)
    install.packages(pkg, Ncpus = 5, )

    # if pkg does not install
    if(!pkg %in% installed.packages()[, 1])
      BiocManager::install(pkg)
  }
}

install_my_pkgs()

install_mlr3 <- function(){
  # https://github.com/mb706/automlr
  # automlr furthermore depends on my CPO extension to mlr, which must be installed from github. Install my private branch which is kept in a state compatible to automlr.
  devtools::install_github("mb706/mlr", ref = "mb706_CPO")
  
  # install ALL deps!
  devtools::install_github("mlr-org/automlr")
  devtools::install_github("mlr-org/automlr", dependencies = c("Depends", "Imports", "Suggests"))
  
  
  # It is highly recommended to install my forks of the e1071, kernlab and mda packages, which fix bugs that otherwise regularly lead to R crashing or hanging:
  devtools::install_github("mb706/e1071")
  devtools::install_github("mb706/kernlab")
  devtools::install_github("mb706/mda")
  
  
  # https://github.com/mlr-org/mlr3pipelines
  
  
  # pkpd analysis (nibr)
  install.packages("xgxr")

}
install_mlr3()

# idea2 (may re-install dependencies)
#if (!require("pacman")) {
#  install.packages("pacman");library(pacman)
#}
#pacman::p_install(char = need_pkgs)
#pacman::p_install(need_pkgs, character.only=T)

# idea3 (works along the lines of idea1)
#wranglr::need_pkgs(pkgs)


# ** installing internal packages**

install_drop <- function(){
  pkgs = c('~/Dropbox/public/github_wranglr',
          '~/projects/packs_hass',
          '~/projects/packs_my.hass',
          '~/projects/packs_mypack',
          '~/projects/packs_rnaseq',
          '~/projects/packs_cancergenes',
          '~/Dropbox/iacsSVN/RPacks/SaturnV',
          '~/Dropbox/public/gitlab_gganimate_heat',
          '~/Dropbox/public/flowr/ultraseq/ultraseq',
          '~/Dropbox/public/flowr/my.ultraseq/my.ultraseq')
  
  # pkgs = pkgs[9:10]
  for(pkg in pkgs){
    message("installing: ", pkg)
    try(devtools::install(pkg))
  }

}
install_drop()


# **install github pkgs**
install_gh_pkgs <- function(){
  gh_pkgs = c(
              
              "mjkallen/rlogging",
              # compbio
              "parklab/nozzle",
              "chrisamiller/fishplot",
              "hdng/clonevol",
              "mikelove/tximport",
              
              # plotting
              "AliciaSchep/gglabeller",
              "dgrtwo/gganimate",
              "mskcc/facets",
              
              # stat pkgs
              "https://github.com/olliemcdonald/siapopr"
              
              )
  
  pacman::p_install_gh(gh_pkgs)
}

install_gh_pkgs()

# SIApop requires java 8
# sudo apt-get install oracle-java8-installer
# make java 8, default:
# sudo apt install oracle-java8-set-default
# sudo apt-get install libgsl0-dev
# sudo apt-get install gsl-bin
# vignette=T









#END
