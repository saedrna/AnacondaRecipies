mkdir build
cd build

cmake -GNinja ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DBUILD_SHARED_LIBS=ON ^
      -DCMAKE_BUILD_TYPE=Release ^
      ../

if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1
