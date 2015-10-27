#!/bin/bash

# Build Docker image.
docker build -t ashgillman/stir:depend  ./depend
docker build -t ashgillman/stir:3.0     ./3.0
docker build -t ashgillman/stir:latest  ./latest
docker build -t ashgillman/stir:explore ./explore

# Run the tests.
docker run \
       -w /STIR-rel_3_00/recon_test_pack/ \
       ashgillman/stir:explore \
       ./run_tests.sh --mpicmd "mpirun -np $(getconf _NPROCESSORS_ONLN)"
