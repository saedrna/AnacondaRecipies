#!/bin/bash
SHORT_OS_STR=$(uname -s)

if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
    export LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
fi

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
      -DCMAKE_SKIP_RPATH=ON \
  	  -DOIIO_BUILD_TOOLS=OFF \
	  -DOIIO_BUILD_TESTS=OFF \
	  -DJPEG_LIBRARY=$PREFIX/lib/libjpeg.a \
	  -DHIDE_SYMBOLS=ON \
      -DUSE_DICOM=OFF \
      -DUSE_FFMPEG=OFF \
      -DUSE_FIELD3D=OFF \
      -DUSE_FREETYPE=OFF \
      -DUSE_GIF=OFF \
      -DUSE_NUKE=OFF \
      -DUSE_OCIO=OFF \
      -DUSE_OPENCV=OFF \
      -DUSE_OPENJPEG=OFF \
      -DUSE_OPENSSL=OFF \
      -DUSE_PTEX=OFF \
      -DUSE_PYTHON=OFF \
      -DUSE_QT=OFF \
      -DUSE_WEBP=OFF \
      -DBUILDSTATIC=OFF \
      -DBUILD_MISSING_PYBIND11=OFF \
      -DBUILD_MISSING_DEPS=OFF \
      -DCMAKE_DISABLE_FIND_PACKAGE_Git=OFF \
      -DVERBOSE=ON \
      -DBUILD_PYBIND11_FORCE=OFF \
      ../
else
cmake -G "Ninja" \
      -DCMAKE_AR=$BUILD_PREFIX/bin/$HOST-ar \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_SKIP_RPATH=ON \
      -DCMAKE_SYSROOT=$BUILD_PREFIX/$HOST/sysroot \
  	  -DOIIO_BUILD_TOOLS=OFF \
	  -DOIIO_BUILD_TESTS=OFF \
	  -DJPEG_LIBRARY=$PREFIX/lib/libjpeg.a \
	  -DHIDE_SYMBOLS=ON \
      -DUSE_DICOM=OFF \
      -DUSE_FFMPEG=OFF \
      -DUSE_FIELD3D=OFF \
      -DUSE_FREETYPE=OFF \
      -DUSE_GIF=OFF \
      -DUSE_NUKE=OFF \
      -DUSE_OCIO=OFF \
      -DUSE_OPENCV=OFF \
      -DUSE_OPENJPEG=OFF \
      -DUSE_OPENSSL=OFF \
      -DUSE_PTEX=OFF \
      -DUSE_PYTHON=OFF \
      -DUSE_QT=OFF \
      -DUSE_WEBP=OFF \
      -DBUILDSTATIC=OFF \
      -DBUILD_MISSING_PYBIND11=OFF \
      -DBUILD_MISSING_DEPS=OFF \
      -DCMAKE_DISABLE_FIND_PACKAGE_Git=OFF \
      -DVERBOSE=ON \
      -DBUILD_PYBIND11_FORCE=OFF \
      ../
fi

cmake --build . --target install --config Release
