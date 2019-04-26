#!/bin/bash

if [[ $(uname) == Darwin ]]; then
  export LIBRARY_SEARCH_VAR=DYLD_FALLBACK_LIBRARY_PATH
elif [[ $(uname) == Linux ]]; then
  export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH
fi

mkdir build_gcc
cd build_gcc

cmake -G "Ninja" \
      -DCMAKE_AR=$BUILD_PREFIX/bin/x86_64-conda_cos6-linux-gnu-ar \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_SYSROOT=$BUILD_PREFIX/x86_64-conda_cos6-linux-gnu/sysroot \
      ../

cmake --build . --target install --config Release
