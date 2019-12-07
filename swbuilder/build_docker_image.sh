#!/usr/bin/env bash
# maintainer: Ravi Chandran

time docker image build                 \
    --build-arg USERNAME=${USER}        \
    --file install_swbuilder.dockerfile \
    --tag swbuilder:v1 .

docker image ls
