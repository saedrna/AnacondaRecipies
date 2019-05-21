#!/bin/bash

# https://github.com/conda-forge/gsl-feedstock/issues/34#issuecomment-449305702
export LIBS="-lcblas -lm"

./configure --prefix=${PREFIX}

make -j${CPU_COUNT} ${VERBOSE_AT}
make check
make install

rm "$PREFIX"/lib/libgslcblas.*
ln -s "$PREFIX/lib/libopenblas${SHLIB_EXT}" "$PREFIX/lib/libgslcblas${SHLIB_EXT}"

if [ "$(uname)" == "Darwin" ]; then
    ln -s "$PREFIX/lib/libopenblas${SHLIB_EXT}" "$PREFIX/lib/libgslcblas.0${SHLIB_EXT}"
elif [ "$(uname)" == "Linux" ]; then
    ln -s "$PREFIX/lib/libopenblas${SHLIB_EXT}" "$PREFIX/lib/libgslcblas${SHLIB_EXT}.0"
fi

# We can remove this when we start using the new conda-build.
find $PREFIX -name '*.la' -delete
