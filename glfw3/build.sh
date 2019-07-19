#!/bin/bash

mkdir build
cd build

if [[ $(uname) == Darwin ]]; then
cmake -GNinja \
      -DCMAKE_SKIP_BUILD_RPATH=FALSE \
      -DCMAKE_BUILD_WITH_INSTALL_RPATH=FALSE \
      -DCMAKE_INSTALL_RPATH=$PREFIX/lib \
      -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=TRUE \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_PREFIX_PATH=$PREFIX \
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
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DGLFW_BUILD_EXAMPLES=0 \
      -DGLFW_BUILD_TESTS=0 \
      -DGLFW_BUILD_DOCS=0 \
      ../
fi
cmake --build . --target install --config Release

if [[ "$OSTYPE" == "darwin"* ]]; then
  install_name_tool -id @rpath/libglfw.3.dylib $PREFIX/lib/libglfw.3.2.dylib
fi
