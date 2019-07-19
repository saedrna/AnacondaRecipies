#!/bin/bash

# https://github.com/conda-forge/gsl-feedstock/issues/34#issuecomment-449305702
export LIBS="-lcblas -lm"

./configure --prefix=${PREFIX}

make -j${CPU_COUNT} ${VERBOSE_AT}
make check
make install

exit 0