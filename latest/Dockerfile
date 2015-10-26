# -*- docker-image-name: "ashgillman/stir:latest" -*-
FROM ashgillman/stir:depends
MAINTAINER Ashley Gillman <ashley.gillman@csiro.au>

# Build STIR
ENV STIR_VER master
RUN curl -L https://github.com/UCL/STIR/archive/${STIR_VER}.tar.gz \
    | tar xz
RUN mkdir /STIR-${STIR_VER}/build \
    && cd /STIR-${STIR_VER}/build \
    && cmake /STIR-${STIR_VER} -DSTIR_MPI=ON \
    && make -j$(nproc) \
    && make install \
    && cd ..
