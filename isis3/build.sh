mkdir build
cd build

#   -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -Wno-deprecated-declarations -Wno-misleading-indentation" \

cmake -GNinja \
      -DJP2KFLAG=OFF \
      -Dpybindings=OFF \
      -DbuildTests=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DOPENCV_INCLUDE_DIR=$PREFIX/include/opencv4 \
      ../isis

cmake --build . --target install --config Release
