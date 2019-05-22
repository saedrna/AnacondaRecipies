mkdir build
cd build


if [ "$(uname)" == "Darwin" ]; then
cmake -GNinja \
      -DJP2KFLAG=OFF \
      -Dpybindings=OFF \
      -DbuildTests=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DOPENCV_INCLUDE_DIR=$PREFIX/include/opencv4 \
      ../isis
elif [ "$(uname)" == "Linux" ]; then
cmake -GNinja \
      -DJP2KFLAG=OFF \
      -Dpybindings=OFF \
      -DbuildTests=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -Wno-deprecated-declarations -Wno-misleading-indentation" \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DOPENCV_INCLUDE_DIR=$PREFIX/include/opencv4 \
      -DCHOLMOD_INCLUDE_DIR=$PREFIX/include/suitesparse \
      ../isis
fi

cmake --build . --target install --config Release
