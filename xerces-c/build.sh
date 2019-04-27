#!/bin/bash
mkdir build_gcc
cd build_gcc

cmake -GNinja \
    -DCMAKE_BUILD_TYPE=Release              \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DBUILD_SHARED_LIBS=ON \
    ../

cmake --build . --config Release --target install
