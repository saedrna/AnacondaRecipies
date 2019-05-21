mkdir build
cd build
cmake -GNinja \
      -DJP2KFLAG=OFF \
      -Dpybindings=OFF \
      -DbuildTests=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -Wno-deprecated-declarations -Wno-misleading-indentation" \
      ../isis

cmake --build . --target install --config Release
