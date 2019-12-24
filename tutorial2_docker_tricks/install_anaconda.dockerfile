# Dockerfile for hypothetical SW build system
FROM ubuntu:18.04
LABEL maintainer="Ravi Chandran"

SHELL ["/bin/bash", "-c"]

# Using Debian Anaconda 3 prerequisites for Ubuntu from here: https://docs.anaconda.com/anaconda/install/linux/#prerequisites
# Also need wget for installing Anaconda
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --quiet --no-install-recommends install \
        libgl1-mesa-glx \
        libegl1-mesa \
        libxrandr2 \
        libxss1 \
        libxcursor1 \
        libxcomposite1 \
        libasound2 \
        libxi6 \
        libxtst6 \
        wget \
    && apt-get -y autoremove \
    && apt-get clean autoclean \
    && rm -fr /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

# install Anaconda by downloading the installer via the local http server
ARG ANACONDA
RUN wget --no-proxy http://10.0.2.15:8888/${ANACONDA} -O ~/anaconda.sh \
    && /bin/bash ~/anaconda.sh -b -p /opt/conda \
    && rm ~/anaconda.sh \
    && rm -fr /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

# set path to conda
ENV PATH="$PATH:/opt/conda/bin"

# update Anaconda packages
RUN conda update conda \
    && conda update anaconda \
    && conda update --all

# Create non-root user:group and generate a home directory to support SSH
ARG USERNAME
RUN adduser --disabled-password --gecos '' ${USERNAME} \
    && adduser ${USERNAME} sudo                        \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Run container as non-root user from here onwards
USER ${USERNAME}

# run bash when container is started
ENTRYPOINT [ "/bin/bash" ]
