#!/bin/bash

set -ex

if [[ $(uname) == Darwin ]]; then
  export LIBRARY_SEARCH_VAR=DYLD_FALLBACK_LIBRARY_PATH
elif [[ $(uname) == Linux ]]; then
  export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH
fi


mkdir build_gcc
cd build_gcc

if [[ $(uname) == Darwin ]]; then
cmake -GNinja \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_CUDA=OFF \
  -DWITH_DAVIDSDK=OFF \
  -DWITH_DSSDK=OFF \
  -DWITH_ENSENSO=OFF \
  -DWITH_FZAPI=OFF \
  -DWITH_LIBUSB=OFF \
  -DWITH_OPENGL=OFF \
  -DWITH_OPENNI=OFF \
  -DWITH_OPENNI2=OFF \
  -DWITH_PCAP=OFF \
  -DWITH_PNG=OFF \
  -DWITH_QHULL=ON \
  -DWITH_QT=OFF \
  -DWITH_VTK=OFF \
  -DBUILD_global_tests=OFF \
  -DBUILD_examples=OFF \
  -DBUILD_tools=OFF \
  -DBUILD_apps=OFF \
  ../
else
cmake -GNinja \
  -DCMAKE_AR=$BUILD_PREFIX/bin/$HOST-ar \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_CUDA=OFF \
  -DWITH_DAVIDSDK=OFF \
  -DWITH_DSSDK=OFF \
  -DWITH_ENSENSO=OFF \
  -DWITH_FZAPI=OFF \
  -DWITH_LIBUSB=OFF \
  -DWITH_OPENGL=OFF \
  -DWITH_OPENNI=OFF \
  -DWITH_OPENNI2=OFF \
  -DWITH_PCAP=OFF \
  -DWITH_PNG=OFF \
  -DWITH_QHULL=ON \
  -DWITH_QT=OFF \
  -DWITH_VTK=OFF \
  -DBUILD_global_tests=OFF \
  -DBUILD_examples=OFF \
  -DBUILD_tools=OFF \
  -DBUILD_apps=OFF \
  ../
fi

cmake --build . --target install --config Release
