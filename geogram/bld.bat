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

set CL=/MP

cmake -G "Visual Studio 17 2022" -A x64 ^
    -DBUILD_SHARED_LIBS=ON ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
    -DVORPALINE_PLATFORM=Win-vs-dynamic-generic ^
    -DGEOGRAM_LIB_ONLY=ON ^
    -DGEOGRAM_WITH_LEGACY_NUMERICS=OFF ^
    -DGEOGRAM_WITH_GRAPHICS=OFF ^
    -DGEOGRAM_WITH_LUA=OFF ^
    ../

if errorlevel 1 exit 1

cmake --build . --target install --config Release

if errorlevel 1 exit 1

exit 0
