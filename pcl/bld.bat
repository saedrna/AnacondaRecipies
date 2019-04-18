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
  -DWITH_CUDA=OFF ^
  -DWITH_DAVIDSDK=OFF ^
  -DWITH_DSSDK=OFF ^
  -DWITH_ENSENSO=OFF ^
  -DWITH_FZAPI=OFF ^
  -DWITH_LIBUSB=OFF ^
  -DWITH_OPENGL=OFF ^
  -DWITH_OPENNI=OFF ^
  -DWITH_OPENNI2=OFF ^
  -DWITH_PCAP=OFF ^
  -DWITH_PNG=OFF ^
  -DWITH_QHULL=ON ^
  -DWITH_QT=OFF ^
  -DWITH_VTK=OFF ^
  -DBUILD_global_tests=OFF ^
  -DBUILD_examples=OFF ^
  -DBUILD_tools=OFF ^
  -DBUILD_apps=OFF ^
  ../

if errorlevel 1 exit 1

cmake --build . --target install --config Release
if errorlevel 1 exit 1
