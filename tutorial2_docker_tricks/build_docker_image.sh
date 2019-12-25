#!/usr/bin/env bash
# purpose: Create Docker image with Ubuntu 18.04 and Anaconda 3
# maintainer: Ravi Chandran

# Stop HTTP server in case it was already running
# Reference: https://stackoverflow.com/a/37214138
kill -9 `ps -ef | grep http.server | grep 8888 | awk '{print $2}'`

# Start HTTP server to serve files from the folder named installer
# Place the file downloaded from https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
# in installer/
# Note that 10.0.2.15 is one of the interface IP addresses that 
# shows up inside a VirtualBox VM associated with an interface
cd installer
python3 -m http.server --bind 10.0.2.15 8888 &
cd ..

ANACONDA=Anaconda3-2019.10-Linux-x86_64.sh

time docker image build                 \
    --build-arg USERNAME=${USER}        \
    --build-arg ANACONDA=$ANACONDA      \
    --file install_anaconda.dockerfile  \
    --tag anaconda_ubuntu1804:v1 .      \
    |& tee $BASH_SOURCE.log

# Stop HTTP server
kill -9 `ps -ef | grep http.server | grep 8888 | awk '{print $2}'`

docker image ls

