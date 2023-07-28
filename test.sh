
# download rocker image and test it
tag=4.2.2
tag=4.2.3
tag=4.3

docker pull rocker/verse:${tag}
docker run -ti -e ROOT=TRUE rocker/verse:${tag} "R"

docker run -ti \
    --rm \
    -v /:/host_root \
    -w $(pwd) \
    rocker/verse:${tag} R "$@"



docker pull rocker/ml-verse:${tag}

docker run -ti -e ROOT=TRUE rocker/ml-verse:${tag} "bash"

docker run -ti -e ROOT=TRUE sahilseth/rocker_ml-verse:${tag} "bash"

# run R and test install and commit

# WARNING: The NVIDIA Driver was not detected.  GPU functionality will not be available.
#    Use the NVIDIA Container Toolkit to start this container with GPU support; see
#    https://docs.nvidia.com/datacenter/cloud-native/ .