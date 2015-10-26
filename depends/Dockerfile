# -*- docker-image-name: "ashgillman/stir:depends" -*-
FROM buildpack-deps:trusty
MAINTAINER Ashley Gillman <ashley.gillman@csiro.au>

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

# Add Tini - take care of runaway processes
ENV TINI_VERSION v0.7.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY docker-entrypoint.sh /
ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]
