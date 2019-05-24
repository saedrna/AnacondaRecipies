#!/bin/bash
mkdir build_gcc
cd build_gcc

if [[ $(uname) == Darwin ]]; then
  export LIBRARY_SEARCH_VAR=DYLD_FALLBACK_LIBRARY_PATH
elif [[ $(uname) == Linux ]]; then
  export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH
fi

if [[ $(uname) == Darwin ]]; then
cmake -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DBUILD_SHARED_LIBS=ON \
    ../
else
cmake -GNinja \
    -DCMAKE_AR=$BUILD_PREFIX/bin/$HOST-ar \
    -DCMAKE_SYSROOT=$BUILD_PREFIX/$HOST/sysroot \
    -DCMAKE_BUILD_TYPE=Release              \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DBUILD_SHARED_LIBS=ON \
    ../
fi

cmake --build . --config Release --target install
