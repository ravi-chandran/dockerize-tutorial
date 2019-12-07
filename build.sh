#!/usr/bin/env bash
# maintainer: Ravi Chandran

docker container run                                       \
    --volume $(pwd)/swbuilder/scripts:/scripts             \
    --volume $1:/workdir                                   \
    --user $(id -u ${USER}):$(id -g ${USER})               \
    --rm -it --name build_swbuilder swbuilder:v1       \
    build
