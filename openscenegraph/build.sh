#!/bin/bash

if [[ $(uname) == Darwin ]]; then
  export LIBRARY_SEARCH_VAR=DYLD_FALLBACK_LIBRARY_PATH
elif [[ $(uname) == Linux ]]; then
  export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH
fi

mkdir build_gcc
cd build_gcc

if [[ $(uname) == Darwin ]]; then
cmake -G "Ninja" \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DLIB_POSTFIX=OFF \
      ../
else
cmake -G "Ninja" \
      -DCMAKE_AR=$BUILD_PREFIX/bin/$HOST-ar \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_SYSROOT=$BUILD_PREFIX/$HOST/sysroot \
      -DLIB_POSTFIX= \
      -DOpenGL_GL_PREFERENCE=LEGACY \
      -DOPENGL_gl_LIBRARY=$CONDA_PREFIX/$HOST/sysroot/usr/lib64/libGL.so \
      ../
fi

cmake --build . --target install --config Release
