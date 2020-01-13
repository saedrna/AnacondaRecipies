@echo ON
setlocal enabledelayedexpansion


if "%PY3K%" == "0" (
    echo "Copying stdint.h for windows"
    copy "%LIBRARY_INC%\stdint.h" %SRC_DIR%\modules\calib3d\include\stdint.h
    copy "%LIBRARY_INC%\stdint.h" %SRC_DIR%\modules\videoio\include\stdint.h
    copy "%LIBRARY_INC%\stdint.h" %SRC_DIR%\modules\highgui\include\stdint.h
)

mkdir build
cd build

for /F "tokens=1,2 delims=. " %%a in ("%PY_VER%") do (
   set "PY_MAJOR=%%a"
   set "PY_MINOR=%%b"
)
set PY_LIB=python%PY_MAJOR%%PY_MINOR%.lib


:: CMake/OpenCV like Unix-style paths for some reason.
set UNIX_PREFIX=%PREFIX:\=/%
set UNIX_LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set UNIX_LIBRARY_BIN=%LIBRARY_BIN:\=/%
set UNIX_LIBRARY_INC=%LIBRARY_INC:\=/%
set UNIX_LIBRARY_LIB=%LIBRARY_LIB:\=/%
set UNIX_SP_DIR=%SP_DIR:\=/%
set UNIX_SRC_DIR=%SRC_DIR:\=/%

cmake -LAH -G "Ninja"                                                               ^
    -DCMAKE_BUILD_TYPE="Release"                                                    ^
    -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX%                                    ^
    -DCMAKE_PREFIX_PATH=%UNIX_LIBRARY_PREFIX%                                       ^
    -DWITH_EIGEN=1                                                                  ^
    -DBUILD_TESTS=0                                                                 ^
    -DBUILD_DOCS=0                                                                  ^
    -DBUILD_PERF_TESTS=0                                                            ^
    -DBUILD_ZLIB=0                                                                  ^
    -DBUILD_opencv_bioinspired=0                                                    ^
    -DBUILD_TIFF=0                                                                  ^
    -DBUILD_PNG=0                                                                   ^
    -DBUILD_OPENEXR=1                                                               ^
    -DBUILD_JASPER=1                                                                ^
    -DBUILD_JPEG=0                                                                  ^
    -DWITH_CUDA=0                                                                   ^
    -DWITH_OPENCL=1                                                                 ^
    -DWITH_OPENNI=0                                                                 ^
    -DWITH_FFMPEG=1                                                                 ^
    -DWITH_GSTREAMER=0                                                              ^
    -DWITH_VTK=0                                                                    ^
    -DJPEG_LIBRARY_RELEASE=%UNIX_LIBRARY_PREFIX%/lib/jpeg-static.lib                ^
    -DINSTALL_C_EXAMPLES=0                                                          ^
    -DOPENCV_EXTRA_MODULES_PATH=%UNIX_SRC_DIR%/opencv_contrib/modules               ^
    -DEXECUTABLE_OUTPUT_PATH=%UNIX_LIBRARY_BIN%                                     ^
    -DLIBRARY_OUTPUT_PATH=%UNIX_LIBRARY_BIN%                                        ^
    -DPYTHON_EXECUTABLE=""                                                          ^
    -DPYTHON_INCLUDE_DIR=""                                                         ^
    -DPYTHON_PACKAGES_PATH=""                                                       ^
    -DPYTHON_LIBRARY=""                                                             ^
    -DPYTHON_NUMPY_INCLUDE_DIRS=""                                                  ^
    -DBUILD_opencv_python2=0                                                        ^
    -DPYTHON2_EXECUTABLE=""                                                         ^
    -DPYTHON2_INCLUDE_DIR=""                                                        ^
    -DPYTHON2_NUMPY_INCLUDE_DIRS=""                                                 ^
    -DPYTHON2_LIBRARY=""                                                            ^
    -DPYTHON2_PACKAGES_PATH=""                                                      ^
    -DOPENCV_PYTHON2_INSTALL_PATH=""                                                ^
    -DBUILD_opencv_python3=0                                                        ^
    -DPYTHON_EXECUTABLE=%UNIX_PREFIX%/python                                        ^
    -DPYTHON_INCLUDE_DIR=%UNIX_PREFIX%/include                                      ^
    -DPYTHON_PACKAGES_PATH=%UNIX_SP_DIR%                                            ^
    -DPYTHON_LIBRARY=%UNIX_PREFIX%/libs/%PY_LIB%                                    ^
    -DPYTHON_NUMPY_INCLUDE_DIRS=%UNIX_SP_DIR%/numpy/core/include                    ^
    -DBUILD_opencv_python3=0                                                        ^
    -DOPENCV_SKIP_PYTHON_LOADER=1                                                   ^
    -DCPU_BASELINE=SSE2                                                             ^
    -DCPU_DISPATCH=SSE2                                                             ^
    -DOPENCV_ENABLE_NONFREE=ON                                                      ^
    ..

if errorlevel 1 exit 1

cmake --build . --target install --config Release
if errorlevel 1 exit 1

exit 0