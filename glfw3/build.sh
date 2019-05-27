#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
  export MACOSX_DEPLOYMENT_TARGET="10.9"
fi

mkdir build
cd build
if [[ $(uname) == Darwin ]]; then
cmake -GNinja \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DGLFW_USE_CHDIR=0 \
      -DGLFW_USE_MENUBAR=0 \
      -DGLFW_BUILD_EXAMPLES=0 \
      -DGLFW_BUILD_TESTS=0 \
      -DGLFW_BUILD_DOCS=0 \
      ../
else
cmake -GNinja \
      -DCMAKE_AR=$BUILD_PREFIX/bin/$HOST-ar \
      -DCMAKE_SYSROOT=$BUILD_PREFIX/$HOST/sysroot \
      -DCMAKE_PREFIX_PATH=${PREFIX}     \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_LIBDIR=lib        \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DGLFW_USE_CHDIR=0 \
      -DGLFW_USE_MENUBAR=0 \
      -DGLFW_BUILD_EXAMPLES=0 \
      -DGLFW_BUILD_TESTS=0 \
      -DGLFW_BUILD_DOCS=0 \
      ../
fi
cmake --build . --target install --config Release
