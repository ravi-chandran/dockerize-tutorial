#!/usr/bin/env bash
# purpose: Run Docker image with Ubuntu 18.04 and Anaconda 3
# maintainer: Ravi Chandran

docker container run                                \
    --volume $(pwd)/workdir:/workdir                \
    --rm -it --name anaconda anaconda_ubuntu1804:v1 \
    |& tee "$(pwd)/workdir/$BASH_SOURCE.log"
