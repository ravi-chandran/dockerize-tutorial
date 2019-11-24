# Dockerfile for hypothetical SW build system
FROM ubuntu:18.04
LABEL maintainer="Ravi Chandran"

SHELL ["/bin/bash", "-c"]

# Create non-root user:group and generate a home directory to support SSH
ARG USERNAME
RUN adduser --disabled-password --gecos '' ${USERNAME} \
    && adduser ${USERNAME} sudo                        \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install SW build system inside docker
# For our toy example, we install build-essential which installs
# required packages for C/C++.
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
       apt-get -y --quiet --no-install-recommends install \
       build-essential \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -fr /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

# Run container as non-root user from here onwards
# so that build output files have the correct owner
USER ${USERNAME}

# set up volumes
VOLUME /home/${USERNAME}/.ssh
VOLUME /scripts
VOLUME /workdir

# run bash script and process the input command
ENTRYPOINT [ "/bin/bash", "/scripts/run_build.sh"]
