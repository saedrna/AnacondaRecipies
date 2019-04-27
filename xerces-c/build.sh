#!/bin/bash
mkdir build_gcc
cd build_gcc

cmake -GNinja \
    -DCMAKE_AR=$BUILD_PREFIX/bin/x86_64-conda_cos6-linux-gnu-ar \
    -DCMAKE_SYSROOT=$BUILD_PREFIX/x86_64-conda_cos6-linux-gnu/sysroot \
    -DCMAKE_BUILD_TYPE=Release              \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DBUILD_SHARED_LIBS=ON \
    ../

cmake --build . --config Release --target install
