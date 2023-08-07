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
img="rocker/ml-verse"
tag="4.3.1"

plat="debian"
ver="4.3"

#export PASSWORD=$(openssl rand -base64 15)
export PASSWORD="sahil.2021"

# find open ports
# Please user port 8888, 80, 443, 8080 ~ 8090, and 8443 ~ 8453
# port=5000
port_rs=$( ss -tln |    awk 'NR > 1{gsub(/.*:/,"",$4); print $4}' |   sort -un |   awk -v n=8788 '$0 < n {next}; $0 == n {n++; next}; {exit}; END {print n}' )
port_ssh=$( ss -tln |    awk 'NR > 1{gsub(/.*:/,"",$4); print $4}' |   sort -un |   awk -v n=8443 '$0 < n {next}; $0 == n {n++; next}; {exit}; END {print n}' )
# port=8787
echo "This script will start rstudio server for the calling user in port " $port
contname="rstudio_"${USER}_$port_rs

ncpu=$(nproc)
mem=$(grep MemTotal /proc/meminfo | awk '{print $2}' | xargs -I {} echo "scale=4; {}/1024^2" | bc)

cat 1>&2 <<END
1. For Rstudio, point your web browser to http://${HOSTNAME}:${port_rs} or 
    ssh -p $port_ssh seths3@${HOSTNAME}
2. log in to RStudio Server using the following credentials:
   user: ${USER}
   password: ${PASSWORD}
When done using RStudio Server, terminate the job by:
   docker kill ${contname};docker rm ${contname}
Container is running ${img}:${tag} with ${ncpu} CPUs
END



# docker run -d -ti -p $port:8787 -v $(pwd):/home/rstudio -e USER=rstudio -e PASSWORD="sahil.2021"  -e USERID=$(id -u) -e GROUPID=10000 -e ROOT=TRUE --cpus=$ncpu --name $contname rocker/verse:latest /init
# --user ${USER}
#MOUNTS="-v $HOME:/home/seths3 -v /stash:/stash -v /:/host_root"
MOUNTS="-v /:/host_root \
-v /home:/home \
-v /mnt/gd4t:/mnt/gd4t \
-v /opt/passwd/passwd:/etc/passwd:ro \
-v /opt/passwd/group:/etc/group:ro \
-v /opt/passwd/shadow:/etc/shadow:ro"

echo $MOUNTS
PORTS="-p $port_rs:8787 -p $port_ssh:22"
# docker rm $(docker ps --filter status=exited -q)

# User-installed R packages go into their home directory
if [ ! -e ${HOME}/rstudio_home/.Renviron ]
then
  printf '\nNOTE: creating ~/.Renviron file\n\n'
  echo "R_LIBS_USER=~/R/${plat}/${ver}" >> ${HOME}/rstudio_home/.Renviron
fi

#   
# -d \
#    -u sseth \
#     -v $HOME:/home/${USER} \
    #-e USER=${USER} \
# setting user is depreciated
docker rm ${contname}
docker run -ti -d \
    --rm \
    ${PORTS} \
    ${MOUNTS} \
    -e ROOT=TRUE \
    -v /home/sseth/rstudio_home:/home/rstudio \
    -e USERID=$(id -u) -e GROUPID=$(id -g) \
    -e PASSWORD=${PASSWORD} \
    -m ${mem}g --cpus=${ncpu} \
    --name ${contname} ${img}:${tag} 
    #"/init"
# JUenQNcfxk8f7c9g/cGv

# docker run -ti -e PASSWORD=${PASSWORD} -e USERID=$(id -u) -e GROUPID=$(id -g) ${MOUNTS} ${PORTS} -e ROOT=TRUE -m 60g --cpus=${ncpu} --name ${contname} ml_verse_ss:4.2.1 "bash"

# remove all stopped containers and their volumes
# https://docs.docker.com/engine/reference/commandline/rm/
# docker ps --filter status=exited -q | xargs docker rm -v
