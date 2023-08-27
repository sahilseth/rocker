#!/usr/bin/env bash

plat="debian"
ver="4.3"
tag="4.3.1"

# User-installed R packages go into their home directory
if [ ! -e ${HOME}/rstudio_home/.Renviron ]
then
  printf '\nNOTE: creating ~/.Renviron file\n\n'
  echo "R_LIBS_USER=~/R/${plat}/${ver}" >> ${HOME}/rstudio_home/.Renviron
fi

# https://pawitp.medium.com/syncing-host-and-container-users-in-docker-39337eff0094
# sudo cp -p /etc/{passwd,group,shadow} /opt/passwd


MOUNTS="-v /:/host_root \
-v /home:/home \
-v /opt/passwd/passwd:/etc/passwd:ro \
-v /opt/passwd/group:/etc/group:ro \
-v/opt/passwd/shadow:/etc/shadow:ro"


#if [[ `echo $HOSTNAME | grep "dst001"` ]]; then
    #-v $HOME:/home/${USER} \
    #-u rstudio \
    # -e USER=rstudio \
    # -e USERID=$(id -u) -e GROUPID=$(id -g) \
    #-u rstudio \
    # --user 1000:1001 \
  #-v /home/sseth/rstudio_home:/home/rstudio \

docker run -ti \
  --rm \
  -w $(pwd) \
  ${MOUNTS} \
  -u $(id -u ${USER}):$(id -g ${USER}) \
  -e HOME=/home/${USER} \
  -e USER=${USER} \
  sahilseth/rocker_ml-verse:${tag} R "$@"

#fi

# system("echo $USER");system("cd $HOME;pwd;ls;echo $USER");.libPaths();getwd()

# install.packages("pacman")