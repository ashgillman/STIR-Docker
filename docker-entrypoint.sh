#!/bin/bash
exec mpirun -np $(nproc) $@
