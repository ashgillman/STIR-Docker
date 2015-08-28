## -*- docker-image-name: "stir:base" -*-
FROM buildpack-deps:trusty
MAINTAINER Ashley Gillman <ashley.gillman@my.jcu.edu.au>

# Possibly for later:
# swig python-dev ipython python-matplotlib mayavi2 vim
# vtk?
RUN apt-get update && apt-get install -y --no-install-recommends \
    cmake-curses-gui \
    libboost-all-dev \
    libinsighttoolkit3-dev \
    libncurses-dev \
    libtiff5-dev \
    mpi-default-bin \
    mpi-default-dev \
    unzip

# Build STIR
ADD secrets.txt /tmp/
RUN curl -O http://stir.sourceforge.net/registered/STIR.zip \
    --netrc-file /tmp/secrets.txt && \
    unzip -a STIR.zip && \
    mkdir ./STIR-build && \
    cd ./STIR-build && \
    cmake ../STIR -DSTIR_MPI=ON && \
    make -j$(nproc) && \
    make install && \
    cd ..
RUN rm /tmp/secrets.txt
