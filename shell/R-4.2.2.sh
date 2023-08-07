#!/usr/bin/env bash

plat="debian"
ver="4.2"
tag="4.2.2"

# User-installed R packages go into their home directory
if [ ! -e ${HOME}/.Renviron ]
then
  printf '\nNOTE: creating ~/.Renviron file\n\n'
  echo "R_LIBS_USER=~/R/${plat}/${ver}" >> ${HOME}/.Renviron
fi

#if [[ `echo $HOSTNAME | grep "dst001"` ]]; then
    docker run -ti -v $HOME:/home/${USER} \
     --rm \
    -v /:/host_root \
    -w $(pwd) \
    -u rstudio \
    sahilseth/rocker_ml-verse:${tag} R "$@"
#fi

# .libPaths();getwd()