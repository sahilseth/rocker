#!/bin/bash
# author: Sahil Seth
#
# rocker/verse container launcher
#
# changed docker image to rocker_pkgs, which has all R packages installed
# 
# bash /home/sseth//dotfiles/shell/rserver-4.2.2.sh
# get into the container to check:
# docker exec -it e00b047b8ac9 bash

#img="sahilseth/rocker_ml-verse"
img="jupyter/datascience-notebook"
tag="2023-08-07"

plat="debian"
ver="4.3"

#export PASSWORD=$(openssl rand -base64 15)
export PASSWORD="sahil.2021"

# find open ports
# Please user port 8888, 80, 443, 8080 ~ 8090, and 8443 ~ 8453
# port=5000
port_nb=$( ss -tln |    awk 'NR > 1{gsub(/.*:/,"",$4); print $4}' |   sort -un |   awk -v n=8788 '$0 < n {next}; $0 == n {n++; next}; {exit}; END {print n}' )
port_ssh=$( ss -tln |    awk 'NR > 1{gsub(/.*:/,"",$4); print $4}' |   sort -un |   awk -v n=8443 '$0 < n {next}; $0 == n {n++; next}; {exit}; END {print n}' )
# port=8787
echo "This script will start rstudio server for the calling user in port " $port
contname="jupnb_"${USER}_$port_rs

ncpu=$(nproc)
mem=$(grep MemTotal /proc/meminfo | awk '{print $2}' | xargs -I {} echo "scale=4; {}/1024^2" | bc)

cat 1>&2 <<END
1. For juoyternb, point your web browser to http://${HOSTNAME}:${port_nb} or 
    ssh -p $port_ssh seths3@${HOSTNAME}
2. log in to jupyter Server using the following credentials:
   user: ${USER}
   password: <your system password>
When done using jupyter Server, terminate the job by:
   docker kill ${contname};docker rm ${contname}
Container is running ${img}:${tag} with ${ncpu} CPUs
END

# User-installed R packages go into their home directory
if [ ! -e ${HOME}/rstudio_home/.Renviron ]
then
  printf '\nNOTE: creating ~/.Renviron file\n\n'
  echo "R_LIBS_USER=~/R/${plat}/${ver}" >> ${HOME}/rstudio_home/.Renviron
fi

if [ ! "$(docker ps -a -q -f name=${contname})" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=${contname})" ]; then
        # cleanup
        echo cleaning up ${contname}
        docker rm ${contname}
    fi
    # run your container
    # docker run -d --name <name> my-docker-image
fi
#docker rm ${contname}
# --user ${USER}
#MOUNTS="-v $HOME:/home/seths3 -v /stash:/stash -v /:/host_root"

MOUNTS="-v /:/host_root \
-v /mnt/gd4t:/mnt/gd4t \
-v /home:/home \
-v /opt/passwd/passwd:/etc/passwd:ro \
-v /opt/passwd/group:/etc/group:ro \
-v /opt/passwd/shadow:/etc/shadow:ro"

echo $MOUNTS
PORTS="-p $port_nb:8888 -p $port_ssh:22"
# docker rm $(docker ps --filter status=exited -q)

echo runnig the container ${contname}
#-v /home/sseth/rstudio_home:/home/rstudio \
docker run -ti \
    --rm \
    ${PORTS} \
    ${MOUNTS} \
    -e USERID=$(id -u) -e GROUPID=$(id -g) \
    -e 
    -e ROOT=TRUE \
    -e JUPYTER_TOKEN=${PASSWORD} \
    -m ${mem}g --cpus=${ncpu} \
    --name ${contname} ${img}:${tag} jupyter-lab

#docker run -d -p 8888:8888 
#-e JUPYTER_TOKEN="yourpassword" -v "$PWD":/home/jovyan/work jupyter/datascience-notebook
# docker pull 

    #"/init"
# JUenQNcfxk8f7c9g/cGv

# docker run -ti -e PASSWORD=${PASSWORD} -e USERID=$(id -u) -e GROUPID=$(id -g) ${MOUNTS} ${PORTS} -e ROOT=TRUE -m 60g --cpus=${ncpu} --name ${contname} ml_verse_ss:4.2.1 "bash"

# remove all stopped containers and their volumes
# https://docs.docker.com/engine/reference/commandline/rm/
# docker ps --filter status=exited -q | xargs docker rm -v
