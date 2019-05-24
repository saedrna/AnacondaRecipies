mkdir build
cd build

export AR=$(basename ${AR})
export RANLIB=$(basename ${RANLIB})
export STRIP=$(basename ${STRIP})
export OBJDUMP=$(basename ${OBJDUMP})
export CC=$(basename ${CC})
export CXX=$(basename ${CXX})

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
      -DCMAKE_SYSROOT=$BUILD_PREFIX/$HOST/sysroot \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -Wno-deprecated-declarations -Wno-misleading-indentation" \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_SHARED_LINKER_FLAGS="-Wl,-lrt ${CMAKE_SHARED_LINKER_FLAGS}" \
      -DCMAKE_EXE_LINKER_FLAGS="-Wl,-lrt ${DCMAKE_EXE_LINKER_FLAGS}" \
      -DJP2KFLAG=OFF \
      -Dpybindings=OFF \
      -DbuildTests=OFF \
      -DOPENCV_INCLUDE_DIR=$PREFIX/include/opencv4 \
      -DCHOLMOD_INCLUDE_DIR=$PREFIX/include/suitesparse \
      ../isis
fi

cmake --build . --target install --config Release
