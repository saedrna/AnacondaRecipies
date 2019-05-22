#!/bin/bash

if [[ $(uname) == Darwin ]]; then
  export LIBRARY_SEARCH_VAR=DYLD_FALLBACK_LIBRARY_PATH
elif [[ $(uname) == Linux ]]; then
  export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH
fi

mkdir build_gcc
cd build_gcc

if [[ $(uname) == Darwin ]]; then
  cmake -G "Ninja" \
        -DCMAKE_INSTALL_PREFIX=$PREFIX \
        -DCMAKE_PREFIX_PATH=$PREFIX \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=ON \
        -DWITH_PROJ4=ON \
        -DWITH_ZLIB=ON \
        -DBUILD_SHARED_LIBS=ON \
        -DWITH_JPEG=ON \
        -DWITH_TIFF=ON \
        -DJPEG_LIBRARY_RELEASE=$PREFIX/lib/libjpeg.a \
        ../
else
  cmake -G "Ninja" \
        -DCMAKE_AR=$BUILD_PREFIX/bin/x86_64-conda_cos6-linux-gnu-ar \
        -DCMAKE_INSTALL_PREFIX=$PREFIX \
        -DCMAKE_PREFIX_PATH=$PREFIX \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=ON \
        -DWITH_PROJ4=ON \
        -DWITH_ZLIB=ON \
        -DBUILD_SHARED_LIBS=ON \
        -DWITH_JPEG=ON \
        -DWITH_TIFF=ON \
        -DJPEG_LIBRARY_RELEASE=$PREFIX/lib/libjpeg.a \
        ../
fi

cmake --build . --target install --config Release
