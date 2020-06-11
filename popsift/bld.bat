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
  -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
  -DCMAKE_PREFIX_PATH=%UNIX_LIBRARY_PREFIX% ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DPopSift_BUILD_EXAMPLES=OFF ^
  -DCUDA_TOOLKIT_ROOT_DIR="C:/Program Files/NVIDIA GPU Computing Toolkit/CUDA/v10.0" ^
  ../

if errorlevel 1 exit 1

cmake --build . --target install --config Release
if errorlevel 1 exit 1

exit 0
