mkdir build_dir
cd build_dir

:: CMake/OpenCV like Unix-style paths for some reason.
set UNIX_PREFIX=%PREFIX:\=/%
set UNIX_LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set UNIX_LIBRARY_BIN=%LIBRARY_BIN:\=/%
set UNIX_LIBRARY_INC=%LIBRARY_INC:\=/%
set UNIX_LIBRARY_LIB=%LIBRARY_LIB:\=/%
set UNIX_SP_DIR=%SP_DIR:\=/%
set UNIX_SRC_DIR=%SRC_DIR:\=/%


:: Configure step.
cmake -GNinja ^
    -DCMAKE_BUILD_TYPE=Release              ^
    -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%UNIX_LIBRARY_PREFIX% ^
    -DBUILD_SHARED_LIBS=ON ^
    ../

if errorlevel 1 exit 1

:: Build.
cmake --build . --config Release --target install
if errorlevel 1 exit 1

exit 0
