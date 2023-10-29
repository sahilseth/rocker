#!/bin/bash
# author: Sahil Seth
#
# rocker/verse container launcher
#
# changed docker image to rocker_pkgs, which has all R packages installed
# 
# get into the container to check:
# docker exec -it e00b047b8ac9 bash
# docker pull sahilseth/rocker_binder:4.3.1_202308

img="sahilseth/rocker_binder"
tag="4.3.1_202308"


# find open ports
# Please user port 8888, 80, 443, 8080 ~ 8090, and 8443 ~ 8453
# port=5000
port_rs=$( ss -tln |    awk 'NR > 1{gsub(/.*:/,"",$4); print $4}' |   sort -un |   awk -v n=8080 '$0 < n {next}; $0 == n {n++; next}; {exit}; END {print n}' )
port_jp=$( ss -tln |    awk 'NR > 1{gsub(/.*:/,"",$4); print $4}' |   sort -un |   awk -v n=8090 '$0 < n {next}; $0 == n {n++; next}; {exit}; END {print n}' )
# port=8787
echo "This script will start rstudio server for the calling user in port " $port
contname="rocker_binder_${USER}_${port_rs}"

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


MOUNTS="-v /:/host_root \
-v ${HOME}:/home/sseth/sseth"
# v /mnt/gd4t:/mnt/gd4t

# -v /opt/passwd/passwd:/etc/passwd:ro \
# -v /opt/passwd/group:/etc/group:ro \
# -v /opt/passwd/shadow:/etc/shadow:ro

echo $MOUNTS
PORTS="-p $port_rs:8787 -p $port_jp:8888"
# docker rm $(docker ps --filter status=exited -q)

# docker rm ${contname}
docker run -ti -d \
    --rm \
    ${PORTS} \
    ${MOUNTS} \
    -e ROOT=TRUE \
    -m ${mem}g --cpus=${ncpu} \
    --name ${contname} ${img}:${tag} \
    jupyter lab --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token='letmein'


# remove all stopped containers and their volumes
# https://docs.docker.com/engine/reference/commandline/rm/
# docker ps --filter status=exited -q | xargs docker rm -v
