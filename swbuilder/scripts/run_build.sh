#!/usr/bin/env bash
# maintainer: Ravi Chandran
#
# This file would typically invoke the build tool
# which may invoke git to access repositories
# requiring SSH keys, and perform the actual build
# on the items in the /workdir folder.
#
# Here we'll simply 

# uncomment for debug
#echo "argc = ${#*}"
#echo "argv = ${*}"

cd /workdir

if [ $1 = "shell" ]; then    
    echo "Starting Bash Shell"
    /bin/bash
elif [ $1 = "build" ]; then
    echo "Performing SW Build"
    gcc helloworld.c -o helloworld -Wall
fi
