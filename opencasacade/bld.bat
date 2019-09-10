mkdir build
cd build

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
    -DUSE_FREEIMAGE=ON ^
    -DINSTALL_DIR=%UNIX_LIBRARY_PREFIX% ^
    -DINSTALL_DIR_BIN=bin ^
    -DINSTALL_DIR_LIB=lib ^
    -DINSTALL_DIR_INCLUDE=include/occt/ ^
    ../

if errorlevel 1 exit 1

cmake --build . --target install --config Release
if errorlevel 1 exit 1

exit 0
