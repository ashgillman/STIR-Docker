#!/bin/bash

# Build Docker image.
docker build -t "stir:base" .

# Load the test data, if required.
if [ ! -d STIR/recon_test_pack ]; then
  curl -O http://stir.sourceforge.net/registered/recon_test_pack.zip \
       --netrc-file secrets.txt
  unzip -a recon_test_pack.zip
  rm recon_test_pack.zip
fi

# Run the tests.
docker run \
       -v $PWD/STIR/recon_test_pack:/STIR/recon_test_pack \
       -w /STIR/recon_test_pack/ \
       stir:base \
       ./run_tests.sh --mpicmd "mpirun -np $(getconf _NPROCESSORS_ONLN)"
