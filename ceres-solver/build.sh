#!/bin/bash

SHORT_OS_STR=$(uname -s)

if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
    export CPPFLAGS="${CPPFLAGS//-std=c++17/-std=c++11}"
    export CXXFLAGS="${CXXFLAGS//-std=c++17/-std=c++11}"

    export LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
fi
if [ "${SHORT_OS_STR}" == "Darwin" ]; then
    OPENMP=""
    QT="0"
    # The old OSX compilers don't know what to do with AVX instructions
    # Therefore, we specify what CPU dispatch operations we want explicitely
    # for OSX..
    # I took this line from the default build flags that get spewed after
    # a successful call to cmake without the parameter specified
    # The default flag as of OpenCV 3.4.4 are:
    # CPU_DISPATCH:STRING=SSE4_1;SSE4_2;AVX;FP16;AVX2;AVX512_SKX
    CPU_DISPATCH_FLAGS="-DCPU_DISPATCH=SSE4_1;SSE4_2;AVX;FP16"
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
      ../

cmake --build . --target install --config Release
