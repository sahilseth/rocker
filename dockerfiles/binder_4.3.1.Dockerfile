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

FROM rocker/binder:4.3.1
LABEL Name=rocker_binder Version=4.3.1

# add my user:
ENV userid=1001
ENV gid=1001
ENV username=sseth

USER root

# for ggstatsplot --> gmp/Rmpfr
RUN apt-get -y update && apt-get install -y libmpfr-dev libgmp3-dev
# for ggrastr --> ragg --> textshaping
RUN apt-get -y update && apt-get install -y libharfbuzz-dev libfribidi-dev

# install rsync 
RUN apt-get install -y rsync nano

# install AWS tools, and other mounting tools
RUN apt-get install -y s3fs awscli sshfs

# install docker
RUN apt-get update && \
    #apt-get -qy full-upgrade && \
    apt-get install -qy curl && \
    curl -sSL https://get.docker.com/ | sh

# install jupyter (assuming it will install the latest version)
# RUN /rocker_scripts/install_jupyter.sh

# install latest notebook
# https://raw.githubusercontent.com/rocker-org/rocker-versioned2/master/scripts/install_jupyter.sh
# is installing an older version currently
# pip index versions jupyterlab
# pip index versions jupyter
# pip index versions notebook
RUN pip install notebook==7.0.2

RUN groupadd --gid ${gid} ${username} && useradd --create-home --uid ${userid} --gid ${gid} ${username} && adduser ${username} sudo
# RUN passwd sseth; default pwd
RUN echo ${username}:letmein | sudo chpasswd

# ref:
# https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/binder_4.3.1.Dockerfile
# now as this user:
USER ${username}

# installing apps
RUN mkdir ~/apps
# installing mamba forge:
# https://github.com/yoshida-lab/docker-base/blob/master/cpu/Dockerfile
RUN curl -so ~/mambaforge.sh -L https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh \
    && chmod +x ~/mambaforge.sh \
    && ~/mambaforge.sh -b -p ~/apps/mambaforge \
    && rm ~/mambaforge.sh \
    && umask 000

ENV user=${username}
ENV PATH=/home/${user}/apps/mambaforge/condabin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false

# RUN echo ${USER}
# RUN echo ${user}
# RUN mamba --version
# RUN cp /scripts/rbinder_custom/omics431.yml omics431.yml
# RUN mamba create -n omics431 --clone omics431.yml


# running rstudio withing jupyterlab
ENV NB_USER=${username}
EXPOSE 8888
EXPOSE 8787

CMD ["/bin/sh", "-c", "jupyter lab --ip 0.0.0.0 --no-browser"]

USER ${NB_USER}

WORKDIR /home/${NB_USER}

#CMD ["/init", "jupyter notebook --ip 0.0.0.0"]

# don't need this
# /init will run by default and start rstudio
# CMD ["sh", "-c", "/usr/games/fortune -a | cowsay"]

# build the docker image
# cd ~/projects_pub/seths3_rocker
# docker build . -f dockerfiles/ml_verse_ss_4.2.1.Dockerfile -t ml_verse_ss_draft:4.2.1
