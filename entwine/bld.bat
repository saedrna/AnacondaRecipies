mkdir build
cd build

cmake -GNinja ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=Release ^
      -DCMAKE_LIBRARY_PATH="%LIBRARY_LIB%" ^
      -DCMAKE_INCLUDE_PATH="%INCLUDE_INC%" ^
      -DBUILD_SHARED_LIBS=ON ^
      -DWITH_TESTS=OFF ^
      %SRC_DIR%
if errorlevel 1 exit 1

cmake --build . --target install --config Release
if errorlevel 1 exit 1

exit 0
