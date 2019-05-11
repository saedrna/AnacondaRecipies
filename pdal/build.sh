#!/bin/bash

set -ex

mkdir build
cd build

export CXXFLAGS="${CXXFLAGS} -std=c++11"
if [ "$(uname)" == "Linux" ]; then
   export LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
fi

cmake -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_LIBRARY_PATH=$PREFIX/lib \
  -DCMAKE_INCLUDE_PATH=$PREFIX/include \
  -DBUILD_PLUGIN_GREYHOUND=ON \
  -DBUILD_PLUGIN_I3S=ON \
  -DBUILD_PLUGIN_PCL=OFF \
  -DBUILD_PLUGIN_PYTHON=OFF \
  -DPDAL_PYTHON_LIBRARY="libPython${SHLIB_EXT}" \
  -DBUILD_PLUGIN_PGPOINTCLOUD=ON \
  -DBUILD_PLUGIN_SQLITE=ON \
  -DBUILD_PLUGIN_ICEBRIDGE=ON \
  -DBUILD_PLUGIN_HEXBIN=ON \
  -DBUILD_PLUGIN_NITF=ON \
  -DENABLE_CTEST=OFF \
  -DWITH_TESTS=OFF \
  -DWITH_ZLIB=ON \
  -DWITH_LAZPERF=ON \
  -DWITH_LASZIP=ON \
  ../

# CircleCI offers two cores.
cmake --build . --target install --config Release
