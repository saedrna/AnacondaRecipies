#!/bin/bash
mkdir build_gcc
cd build_gcc

set -ex

if [[ $(uname) == Darwin ]]; then
  export LIBRARY_SEARCH_VAR=DYLD_FALLBACK_LIBRARY_PATH
elif [[ $(uname) == Linux ]]; then
  export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH
fi

cmake -G "Ninja" \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_C_COMPILER=gcc-8 \
  -DCMAKE_CXX_COMPILER=g++-8 \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_BUILD_TYPE=Release \
  -DPopSift_BUILD_EXAMPLES=OFF \
  -DCUDA_TOOLKIT_ROOT_DIR="/opt/cuda/" \
  ../

cmake --build . --target install --config Release
