mkdir build
pushd build

cmake %SRC_DIR% -G "%CMAKE_GENERATOR%" ^
                   -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
                   -D BUILD_SHARED_LIBS=ON ^
                   %SRC_DIR%
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1
