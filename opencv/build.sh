#!/bin/bash
# export http_proxy="http://127.0.0.1:12333"
# export https_proxy="http://127.0.0.1:12333"

mkdir build_gcc
cd build_gcc

if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
    OPENMP="-DWITH_OPENMP=1"
    # Looks like there's a bug in Opencv 3.2.0 for building with FFMPEG
    # with GCC opencv/issues/8097
    export CXXFLAGS="$CXXFLAGS -D__STDC_CONSTANT_MACROS"

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

cmake -G "Ninja" \
    -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DWITH_EIGEN=1 \
    -DBUILD_TESTS=0 \
    -DBUILD_DOCS=0 \
    -DBUILD_PERF_TESTS=0 \
    -DBUILD_ZLIB=0 \
    -DBUILD_opencv_bioinspired=0 \
    -DBUILD_TIFF=0               \
    -DBUILD_PNG=0                \
    -DBUILD_OPENEXR=1            \
    -DBUILD_JASPER=1             \
    -DBUILD_JPEG=0               \
    -DWITH_CUDA=0                \
    -DWITH_OPENCL=1              \
    -DWITH_OPENNI=0              \
    -DWITH_FFMPEG=1              \
    -DWITH_GSTREAMER=0           \
    -DWITH_VTK=0                 \
    -DWITH_V4L=0 \
    -DJPEG_LIBRARY_RELEASE=$PREFIX/lib/libjpeg.a  \
    -DINSTALL_C_EXAMPLES=0       \
    -DOPENCV_EXTRA_MODULES_PATH=$SRC_DIR/opencv_contrib/modules \
    -DPYTHON_EXECUTABLE=""       \
    -DPYTHON_INCLUDE_DIR=""      \
    -DPYTHON_PACKAGES_PATH=""    \
    -DPYTHON_LIBRARY=""          \
    -DPYTHON_NUMPY_INCLUDE_DIRS=""                                    \
    -DBUILD_opencv_python2=0     \
    -DPYTHON2_EXECUTABLE=""      \
    -DPYTHON2_INCLUDE_DIR=""     \
    -DPYTHON2_NUMPY_INCLUDE_DIRS=""                                   \
    -DPYTHON2_LIBRARY=""         \
    -DPYTHON2_PACKAGES_PATH=""   \
    -DOPENCV_PYTHON2_INSTALL_PATH=""                                  \
    -DBUILD_opencv_python3=0     \
    -DOPENCV_SKIP_PYTHON_LOADER=1 \
    ..

cmake --build . --target install --config Release
