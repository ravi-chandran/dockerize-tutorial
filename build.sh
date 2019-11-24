#!usr/bin/env bash
# maintainer: Ravi Chandran

# copy SSH data to temporary folder to avoid changes to the original by the container
cp -r ~/.ssh /tmp/.ssh_build_swbuilder

docker container run                                       \
    --volume $(pwd)/swbuilder/scripts:/scripts             \
    --volume $1:/workdir                                   \
    --volume /tmp/.ssh_build_swbuilder:/home/${USER}/.ssh  \
    --user $(id -u ${USER}):$(id -g ${USER})               \
    --rm -it --name ssh_build_swbuilder swbuilder:v1       \
    build

# clean up SSH data in temporary folder
rm -fr /tmp/.ssh_build_swbuilder