# rocker
Rocker and related NGS containers



# creating a new container:
## 4.2.2

```
tag=4.2.1
tag=4.2.2

docker build . -f dockerfiles/ml_verse_ss_${tag}.Dockerfile -t rocker_ml-verse:${tag}

# run `id` on terminal to get user details, and keep a note of them

# start the container:
docker run -ti -e ROOT=TRUE sahilseth/rocker_ml-verse:${tag} "bash"

docker run -ti -e ROOT=TRUE rocker/ml-verse:${tag} "bash"

# add your own username:
# we need to add bioinfo group as well, so that files created have the right permissions
# change the username and user id below
userid=XX
username=XX
# groupadd --gid 100 sseth && useradd --create-home --uid ${userid} --gid 100 ${username} && adduser ${username} sudo

# change the pwd
sudo passwd sseth

# ON A NEW TERMINAL, and finder the container ID
docker ps
containerid=XXX
docker commit ${containerid} rocker_ml-verse:${tag}

```

## start rocker

Alternatively, you may look at my exact scripts here:

```
img="rocker_ml-verse"
tag="4.2.2"
username="sseth"

export PASSWORD=$(openssl rand -base64 15)

# get ports
port_rs=$( ss -tln |    awk 'NR > 1{gsub(/.*:/,"",$4); print $4}' |   sort -un |   awk -v n=8080 '$0 < n {next}; $0 == n {n++; next}; {exit}; END {print n}' )
port_ssh=$( ss -tln |    awk 'NR > 1{gsub(/.*:/,"",$4); print $4}' |   sort -un |   awk -v n=8443 '$0 < n {next}; $0 == n {n++; next}; {exit}; END {print n}' )
#

contname="rstudio_"${USER}_$port_rs
PORTS="-p $port_rs:8787 -p $port_ssh:22"

MOUNTS="-v $HOME:/home/${username} -v /:/host_root -v /aws-storage:/aws-storage"

ncpu=$(nproc)
mem=$(grep MemTotal /proc/meminfo | awk '{print $2}' | xargs -I {} echo "scale=4; {}/1024^2" | bc)

docker run -ti -d -e PASSWORD=${PASSWORD} ${MOUNTS} ${PORTS} \
    --rm \
    -e ROOT=TRUE \
    -m ${mem}g --cpus=${ncpu} --name ${contname} ${img}:${tag} "/init"

```

