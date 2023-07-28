#!/bin/bash
# author: Sahil Seth
#
# rocker/verse container launcher
#
# changed docker image to rocker_pkgs, which has all R packages installed
# 
# bash /home/sseth//dotfiles/shell/rserver-4.2.2.sh
# get into the container to check:
# docker exec -it <mycontainer> bash

img="sahilseth/rocker_ml-verse"
tag="4.2.2"

export PASSWORD=$(openssl rand -base64 15)

# find open ports
# Please user port 8888, 80, 443, 8080 ~ 8090, and 8443 ~ 8453
# port=5000
port_rs=$( ss -tln |    awk 'NR > 1{gsub(/.*:/,"",$4); print $4}' |   sort -un |   awk -v n=8080 '$0 < n {next}; $0 == n {n++; next}; {exit}; END {print n}' )
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
MOUNTS="-v /:/host_root"
echo $MOUNTS
PORTS="-p $port_rs:8787 -p $port_ssh:22"
# docker rm $(docker ps --filter status=exited -q)
    # -u seths3 \
    # -e USERID=$(id -u) -e GROUPID=$(id -g) \
docker run -ti -d -e PASSWORD=${PASSWORD} ${MOUNTS} ${PORTS} \
    --rm \
    -e ROOT=TRUE \
    -m ${mem}g --cpus=${ncpu} --name ${contname} ${img}:${tag} "/init"
# JUenQNcfxk8f7c9g/cGv

# docker run -ti -e PASSWORD=${PASSWORD} -e USERID=$(id -u) -e GROUPID=$(id -g) ${MOUNTS} ${PORTS} -e ROOT=TRUE -m 60g --cpus=${ncpu} --name ${contname} ml_verse_ss:4.2.1 "bash"

# remove all stopped containers and their volumes
# https://docs.docker.com/engine/reference/commandline/rm/
# docker ps --filter status=exited -q | xargs docker rm -v
