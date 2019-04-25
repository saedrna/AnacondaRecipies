#!/bin/bash
mkdir build_gcc
cd build_gcc

cmake -G "Ninja" \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCATCH_BUILD_TESTING=OFF \
    -DCATCH_BUILD_EXAMPLES=OFF \
    -DCATCH_BUILD_EXTRA_TESTS=OFF \
    ../

cmake --build . --target install --config Release
