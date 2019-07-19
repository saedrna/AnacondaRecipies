set CMAKE_CONFIG=Release

mkdir build_gflags
cd build_gflags

:: CMake/OpenCV like Unix-style paths for some reason.
set UNIX_PREFIX=%PREFIX:\=/%
set UNIX_LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set UNIX_LIBRARY_BIN=%LIBRARY_BIN:\=/%
set UNIX_LIBRARY_INC=%LIBRARY_INC:\=/%
set UNIX_LIBRARY_LIB=%LIBRARY_LIB:\=/%
set UNIX_SP_DIR=%SP_DIR:\=/%
set UNIX_SRC_DIR=%SRC_DIR:\=/%

cmake -G "Ninja" ^
      -DBUILD_SHARED_LIBS=ON ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_PREFIX_PATH=%UNIX_LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
      -DGFLAGS_REGISTER_BUILD_DIR:BOOL=OFF ^
      -DGFLAGS_REGISTER_INSTALL_PREFIX:BOOL=OFF ^
      -DBUILD_gflags_nothreads_LIB:BOOL=OFF ^
      ../

if errorlevel 1 exit 1
cmake --build . --target install --config Release

exit 0
