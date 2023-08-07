# Sahil Seth
# these will use: https://github.com/sahilseth/singularity/blob/master/rocker/Dockerfile_rstudio_ss_4.0.0-ubuntu18.04
# as the reference
# https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/ml-verse_4.2.1.Dockerfile

# https://rocker-project.org/images/#the-versioned-stack
# rocker/ml	Adds CUDA support to rocker/geospatial
# rocker/cuda, rocker/ml, and rocker/ml-verse are Docker images for machine learning and GPU-based computation in R. 
# These images correspond to rocker/r-ver, rocker/tidyverse, and rocker/geospatial, respectively.
# All images are based on the official NVIDIA CUDA docker build recipes, and are installed the reticulate package.

# PROS:
# since reticulate is installed, single-cell stuff should be better I imagine

FROM rocker/ml-verse:4.3.1
LABEL Name=rocker_ml-verse Version=4.3.1

# for ggstatsplot --> gmp/Rmpfr
RUN apt-get -y update && apt-get install -y libmpfr-dev libgmp3-dev
# for ggrastr --> ragg --> textshaping
RUN apt-get -y update && apt-get install -y libharfbuzz-dev libfribidi-dev

# install rsync 
RUN apt-get install -y rsync

# install AWS tools, and other mounting tools
RUN apt-get install -y s3fs awscli sshfs

# add my user:
# RUN groupadd --gid 100 sseth && useradd --create-home --uid 100 --gid 100 sseth && adduser sseth sudo
# RUN passwd sseth
# RUN echo sseth:letmein | sudo chpasswd

# change the pwd for rstudio


# don't need this
# /init will run by default and start rstudio
# CMD ["sh", "-c", "/usr/games/fortune -a | cowsay"]

# build the docker image
# cd ~/projects_pub/seths3_rocker
# docker build . -f dockerfiles/ml_verse_ss_4.2.1.Dockerfile -t ml_verse_ss_draft:4.2.1


