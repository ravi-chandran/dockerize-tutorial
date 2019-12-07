#!/usr/bin/env bash
# maintainer: Ravi Chandran

cd /workdir

if [ $1 = "shell" ]; then    
    echo "Starting Bash Shell"
    /bin/bash
elif [ $1 = "build" ]; then
    echo "Performing SW Build"
    gcc helloworld.c -o helloworld -Wall
fi
