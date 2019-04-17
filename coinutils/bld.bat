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

robocopy %RECIPE_DIR%\ %SRC_DIR%\ CMakeLists.txt Config.cmake.in

cmake -G "Ninja" ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
    ../

if errorlevel 1 exit 1
cmake --build . --target install --config Release

exit 0
