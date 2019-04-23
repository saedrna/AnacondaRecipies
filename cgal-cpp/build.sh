#!/bin/sh

mkdir build && cd build

# needs qt5 for imageio
cmake -LAH -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCGAL_INSTALL_LIB_DIR=lib \
  -DWITH_CGAL_ImageIO=OFF \
  -DWITH_CGAL_Qt5=OFF \
  -DCGAL_HEADER_ONLY=ON \
  ..

cmake --build . --target install --config Release

rm -f $PREFIX/lib/cmake/CGAL/FindBLAS.cmake
rm -f $PREFIX/lib/cmake/CGAL/FindLAPACK.cmake
