#!/bin/bash

SHORT_OS_STR=$(uname -s)

if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
    export LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
fi


mkdir build_gcc
cd build_gcc

cmake -G "Ninja" \
      -DCMAKE_AR=$BUILD_PREFIX/bin/x86_64-conda_cos6-linux-gnu-ar \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_SKIP_RPATH=ON \
      -DCMAKE_SYSROOT=$BUILD_PREFIX/x86_64-conda_cos6-linux-gnu/sysroot \
      -DUSE_TESTS=OFF \
      -DALEMBIC_SHARED_LIBS=ON \
      -DILMBASE_VERSION=2.3.0 \
      ../

cmake --build . --target install --config Release
