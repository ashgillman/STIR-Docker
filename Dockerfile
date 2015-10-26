# -*- docker-image-name: "stir" -*-
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
ENV STIR_VER rel_3_00
RUN curl -L https://github.com/UCL/STIR/archive/${STIR_VER}.tar.gz \
    | tar xz
RUN mkdir /STIR-${STIR_VER}/build \
    && cd /STIR-${STIR_VER}/build \
    && cmake /STIR-${STIR_VER} -DSTIR_MPI=ON \
    && make -j$(nproc) \
    && make install \
    && cd ..

# Add Tini - take care of runaway processes
ENV TINI_VERSION v0.7.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY docker-entrypoint.sh /
ENTRYPOINT ["/tini", "--", "/docker-entrypoint.sh"]
