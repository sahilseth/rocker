
# download rocker image and test it
tag=4.2.2

docker pull rocker/ml-verse:${tag}

docker run -ti -e ROOT=TRUE sahilseth/rocker_ml-verse:${tag} "bash"

# run R and test install and commit