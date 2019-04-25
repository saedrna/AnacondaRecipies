mkdir build_vs
cd build_vs

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
    -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
    -DCATCH_BUILD_TESTING=OFF ^
    -DCATCH_BUILD_EXAMPLES=OFF ^
    -DCATCH_BUILD_EXTRA_TESTS=OFF ^
    ../

if errorlevel 1 exit 1
cmake --build . --target install --config Release
if errorlevel 1 exit 1

exit 0
