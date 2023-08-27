#!/bin/bash
# author: Sahil Seth
# 
# connect to existing container

containerid="rocker_binder_sseth_8080"
tag=202308

docker exec -it ${containerid} /home/sseth/apps/mambaforge/envs/omics431/bin/R "$@"
