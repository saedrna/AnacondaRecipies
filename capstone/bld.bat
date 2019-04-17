@echo ON
setlocal enabledelayedexpansion

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

cmake -G "Ninja" ^
    -DCAPSTONE_BUILD_SHARED=ON ^
    -DCAPSTONE_BUILD_STATIC=ON ^
    -DCAPSTONE_BUILD_STATIC_RUNTIME=OFF ^
    -DCAPSTONE_BUILD_TESTS=OFF ^
    -DCAPSTONE_BUILD_DIET=OFF ^
    -DCAPSTONE_BUILD_CSTOOL=OFF ^
    -DCAPSTONE_X86_ONLY=ON ^
    -DBUILD_SHARED_LIBS=ON ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
    ../

if errorlevel 1 exit 1
cmake --build . --target install --config Release

exit 0
