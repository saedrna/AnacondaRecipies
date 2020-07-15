#!/bin/bash

SHORT_OS_STR=$(uname -s)

if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
    export LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
fi


mkdir build_gcc
cd build_gcc

if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
    cmake -G "Ninja" \
      -DCMAKE_AR=$BUILD_PREFIX/bin/$HOST-ar \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_SKIP_RPATH=ON \
      -DCMAKE_SYSROOT=$BUILD_PREFIX/$HOST/sysroot \
      -DCMAKE_LIBRARY_PATH=$PREEFIX/lib \
      -DCMAKE_INCLUDE_PATH=$PREFIX/include \
      -DALEMBIC_ILMBASE_HALF_LIB=$PREFIX/lib/libHalf.so \
      -DALEMBIC_ILMBASE_IEXMATH_LIB=$PREFIX/lib/libIexMath.so \
      -DALEMBIC_ILMBASE_IEX_LIB=$PREFIX/lib/libIex.so \
      -DALEMBIC_ILMBASE_ILMTHREAD_LIB=$PREFIX/lib/libIlmThread.so \
      -DALEMBIC_ILMBASE_IMATH_LIB=$PREFIX/lib/libImath.so \
      -DUSE_TESTS=OFF \
      -DALEMBIC_SHARED_LIBS=ON \
      ../
else
    cmake -G "Ninja" \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_SKIP_RPATH=ON \
      -DUSE_TESTS=OFF \
      -DALEMBIC_SHARED_LIBS=ON \
      ../
fi

cmake --build . --target install --config Release
