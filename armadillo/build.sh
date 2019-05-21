#!/usr/bin/env bash

mkdir -p build
cd build

if [[ $(uname) == "Linux" ]]; then
  export LDFLAGS="$LDFLAGS -Wl,-rpath-link,$PREFIX/lib"
fi

cmake -GNinja \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DCMAKE_PREFIX_PATH="${PREFIX}" \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_INSTALL_LIBDIR="lib" \
      ../

cmake --build . --target install --config Release
