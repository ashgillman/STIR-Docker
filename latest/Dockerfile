# -*- docker-image-name: "ashgillman/stir:latest" -*-
FROM ashgillman/stir:depends
MAINTAINER Ashley Gillman <ashley.gillman@csiro.au>

# Build STIR
ENV STIR_VER master
RUN curl -L https://github.com/UCL/STIR/archive/${STIR_VER}.tar.gz \
    | tar xz
RUN mkdir /STIR \
    && cd /STIR \
    && cmake /STIR-${STIR_VER} \
       -DCMAKE_BUILD_TYPE=RELEASE \
       -DSTIR_MPI=ON \
       -DGRAPHICS=PGM \
    && make -j$(nproc) \
    && make install \
    && cd ..
