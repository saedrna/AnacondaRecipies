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
        -DVORPALINE_PLATFORM=Darwin-clang-dynamic \
        -DGEOGRAM_LIB_ONLY=ON \
        -DGEOGRAM_WITH_LEGACY_NUMERICS=OFF \
        -DGEOGRAM_WITH_GRAPHICS=OFF \
        -DGEOGRAM_WITH_LUA=OFF \
        ../
else
  cmake -G "Ninja" \
        -DCMAKE_AR=$BUILD_PREFIX/bin/x86_64-conda_cos6-linux-gnu-ar \
        -DCMAKE_INSTALL_PREFIX=$PREFIX \
        -DCMAKE_PREFIX_PATH=$PREFIX \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBS=ON \
        -DCMAKE_SYSROOT=$BUILD_PREFIX/x86_64-conda_cos6-linux-gnu/sysroot \
        -DVORPALINE_PLATFORM=Linux64-gcc-dynamic \
        -DGEOGRAM_LIB_ONLY=ON \
        -DGEOGRAM_WITH_LEGACY_NUMERICS=OFF \
        -DGEOGRAM_WITH_GRAPHICS=OFF \
        -DGEOGRAM_WITH_LUA=OFF \
        ../
fi
cmake --build . --target install --config Release
