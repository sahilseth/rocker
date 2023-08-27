# creating a new container:

```
tag=4.3.1

docker build . -f dockerfiles/binder_${tag}.Dockerfile -t sahilseth/rocker_binder:${tag}

docker tag sahilseth/rocker_binder:4.3.1 sahilseth/rocker_binder:4.3.1_202308

# start the container:
rserver-431_202308.sh

# run through the setup:
/home/sseth/projects_git/rocker/scripts/setup_431.sh

```




## push to dockerhub

```
#containerid=e4a9a120ade5
#docker commit ${containerid} rocker_ml-verse:${tag}

#docker tag ${containerid} sahilseth/ml-verse:${tag}

docker login
docker push sahilseth/rocker_ml-verse:${tag}

docker push sahilseth/rocker_ml-verse:${tag}
```

