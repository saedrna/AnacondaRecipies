@echo ON
setlocal enabledelayedexpansion

mkdir build-vs
cd build-vs

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
    -DASSIMP_BUILD_TESTS=OFF ^
    -DASSIMP_INSTALL_PDB=OFF ^
    -DASSIMP_BUILD_ASSIMP_VIEW=OFF ^
    -DASSIMP_BUILD_ZLIB=OFF ^
    -DASSIMP_BUILD_SHARED_LIBS=ON ^
    -DASSIMP_BUILD_ASSIMP_TOOLS=OFF ^
    ../

if errorlevel 1 exit 1
cmake --build . --target install --config Release
if errorlevel 1 exit 1

exit 0
