:: Make build directory
mkdir build
cd build

:: Specify location of TBB
set "TBBROOT=%LIBRARY_PREFIX%"

:: Configure
cmake ../ ^
      -G "Ninja" ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_LIBDIR=lib ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DEMBREE_TUTORIALS=OFF ^
      -DEMBREE_ISPC_SUPPORT=OFF
if errorlevel 1 exit 1

:: Compile
cmake --build . --target install --config Release

:: remove tutorial models (which embree installed even when EMBREE_TUTORIALS=off)
:: this is easier than patching embree's cmake
rd /s /q %LIBRARY_PREFIX%/bin/models
if errorlevel 1 exit 1

exit 0
