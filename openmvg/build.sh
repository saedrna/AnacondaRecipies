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
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DOpenMVG_BUILD_SHARED=ON \
      -DOpenMVG_BUILD_DOC=OFF \
      -DOpenMVG_BUILD_EXAMPLES=OFF \
      -DOpenMVG_BUILD_SOFTWARES=ON \
      -DOpenMVG_BUILD_GUI_SOFTWARES=OFF \
      -DEIGEN_INCLUDE_DIR_HINTS=$PREFIX/include/eigen3 \
      -DCERES_DIR_HINTS=$PREFIX/ceres \
      -DFLANN_INCLUDE_DIR_HINTS=$PREFIX/flann \
      -DLEMON_INCLUDE_DIR_HINTS=$PREFIX/include/lemon \
      -DCOINUTILS_INCLUDE_DIR_HINTS=$PREFIX/include/coin \
      -DCLP_INCLUDE_DIR_HINTS=$PREFIX/include/coin \
      -DOSI_INCLUDE_DIR_HINTS=$PREFIX/include/coin \
      -DOpenMVG_USE_INTERNAL_CLP=OFF \
      -DOpenMVG_USE_INTERNAL_COINUTILS=OFF \
      -DOpenMVG_USE_INTERNAL_OSI=OFF \
      -DOpenMVG_USE_INTERNAL_EIGEN=OFF \
      -DOpenMVG_USE_INTERNAL_CEREAL=OFF \
      -DOpenMVG_USE_INTERNAL_CERES=OFF \
      -DOpenMVG_USE_INTERNAL_FLANN=OFF \
      -DFLANN_LIBRARY=$PREFIX/lib/flann_cpp_s.lib \
      -DJPEG_LIBRARY_RELEASE=$PREFIX/lib/jpeg-static.lib \
      -DTARGET_ARCHITECTURE=core \
      ../src 
else
cmake -G "Ninja" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DOpenMVG_BUILD_SHARED=ON \
      -DOpenMVG_BUILD_DOC=OFF \
      -DOpenMVG_BUILD_EXAMPLES=OFF \
      -DOpenMVG_BUILD_SOFTWARES=ON \
      -DOpenMVG_BUILD_GUI_SOFTWARES=OFF \
      -DEIGEN_INCLUDE_DIR_HINTS=$PREFIX/include/eigen3 \
      -DCERES_DIR_HINTS=$PREFIX/ceres \
      -DFLANN_INCLUDE_DIR_HINTS=$PREFIX/flann \
      -DLEMON_INCLUDE_DIR_HINTS=$PREFIX/include/lemon \
      -DCOINUTILS_INCLUDE_DIR_HINTS=$PREFIX/include/coin \
      -DCLP_INCLUDE_DIR_HINTS=$PREFIX/include/coin \
      -DOSI_INCLUDE_DIR_HINTS=$PREFIX/include/coin \
      -DOpenMVG_USE_INTERNAL_CLP=OFF \
      -DOpenMVG_USE_INTERNAL_COINUTILS=OFF \
      -DOpenMVG_USE_INTERNAL_OSI=OFF \
      -DOpenMVG_USE_INTERNAL_EIGEN=OFF \
      -DOpenMVG_USE_INTERNAL_CEREAL=OFF \
      -DOpenMVG_USE_INTERNAL_CERES=OFF \
      -DOpenMVG_USE_INTERNAL_FLANN=OFF \
      -DFLANN_LIBRARY=$PREFIX/lib/libflann_cpp_s.a \
      -DJPEG_LIBRARY_RELEASE=$PREFIX/lib/libjpeg.a \
      -DTARGET_ARCHITECTURE=core \
      ../src 
fi

cmake --build . --target install --config Release
