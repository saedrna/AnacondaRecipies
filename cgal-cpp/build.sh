#!/bin/sh

mkdir build && cd build

# needs qt5 for imageio
if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
  cmake -LAH -GNinja \
    -DCMAKE_AR=$BUILD_PREFIX/bin/$HOST-ar \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DCGAL_INSTALL_LIB_DIR=lib \
    -DWITH_CGAL_ImageIO=OFF \
    -DWITH_CGAL_Qt5=OFF \
    -DCGAL_HEADER_ONLY=ON \
    ..
else
  cmake -LAH -GNinja \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DCGAL_INSTALL_LIB_DIR=lib \
    -DWITH_CGAL_ImageIO=OFF \
    -DWITH_CGAL_Qt5=OFF \
    -DCGAL_HEADER_ONLY=ON \
    ..
fi

cmake --build . --target install --config Release

rm -f $PREFIX/lib/cmake/CGAL/FindBLAS.cmake
rm -f $PREFIX/lib/cmake/CGAL/FindLAPACK.cmake
