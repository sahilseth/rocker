# will add things here, and later move these to the dockerfile as much as possible:

# start docker the first time, and change the TAG
imgi="rocker_binder"
tagi="4.3.1"
contname="rocker_binder_sseth_8080"

# enter the container
docker exec -it ${contname} bash
# OR
rocker

# # saved rstudio preferences
# # custom setup
docker commit ${contname} rocker_binder:202308

# once we update rstudio/jupterlab
# we may want to reinstall the environment as well
# we can make a few updates, downstream

# setup omics 431
#conda env export > omics431.yml

# clone the env (for now)
# mamba create -n omics431 --clone sseth/apps/mambaforge/envs/omics431

# homedir setup:
ln -s sseth/projects .
ln -s sseth/projects2 .
ln -s sseth/projects_git .

# done to add stuff to bashrc
mamba init

# install omics431
# follow: scripts/env_omics431.sh


"""
mamba env list
# conda environments:
#

R
library(MOVICS)

great movics is installed!

"""
/home/sseth/apps/mambaforge/envs/omics431/bin/R -e 'IRkernel::installspec(name = "R431omics", displayname = "R 4.3.1 omics")'

# we confirm that its installed
ls .local/share/jupyter/kernels/
# r431omics

.libPaths("/home/seths3/apps/mambaforge/envs/omics431/lib/R/library")

# this is the main rstudio
# change the rstudio server for init
# edit the rstudio path
vi /etc/rstudio/rserver.conf
# rsession-which-r=/home/sseth/apps/mambaforge/envs/omics431/bin/R

# start the rstudio server
# for some reason this does not work
# rstudio-server restart 
/init




# https://support.nesi.org.nz/hc/en-gb/articles/360004337836-RStudio-via-Jupyter-on-NeSI#:~:text=RStudio%20can%20be%20accessed%20as,where%20RStudio%20will%20be%20accessible.



rocker_commit
