
mkdir build
cd build

REM This is a fix for a CMake bug where it crashes because of the "/GL" flag
REM See: https://gitlab.kitware.com/cmake/cmake/issues/16282
REM set CXXFLAGS=%CXXFLAGS:-GL=%
REM set CFLAGS=%CFLAGS:-GL=%

:: CMake/OpenCV like Unix-style paths for some reason.
set UNIX_PREFIX=%PREFIX:\=/%
set UNIX_LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set UNIX_LIBRARY_BIN=%LIBRARY_BIN:\=/%
set UNIX_LIBRARY_INC=%LIBRARY_INC:\=/%
set UNIX_LIBRARY_LIB=%LIBRARY_LIB:\=/%
set UNIX_SP_DIR=%SP_DIR:\=/%
set UNIX_SRC_DIR=%SRC_DIR:\=/%

cmake -G "Ninja"              ^
    -DCMAKE_BUILD_TYPE=Release              ^
    -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%UNIX_LIBRARY_PREFIX% ^
    -DBUILD_SHARED_LIBS=ON ^
    -Denable_blaslib=OFF ^
    -Denable_single=ON ^
    -Denable_double=ON ^
    -Denable_complex16=ON ^
    -Denable_complex=ON ^
    -Denable_tests=OFF ^
    -Denable_doc=OFF ^
    -Denable_matlab_mex=OFF ^
    ..

if errorlevel 1 exit 1

cmake --build . --target install

if errorlevel 1 exit 1

exit 0
