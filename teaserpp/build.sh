if [[ $(uname) == "Linux" ]]; then
    export LDFLAGS="$LDFLAGS -Wl,-rpath,$BUILD_PREFIX/lib -Wl,-rpath-link,$BUILD_PREFIX/lib -L$BUILD_PREFIX/lib"
fi

mkdir build
cd build

cmake -LAH -GNinja \
    -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON -DCMAKE_MACOSX_RPATH=ON \
    -DCMAKE_SYSROOT=$BUILD_PREFIX/$HOST/sysroot \
    ..

cmake --build . --target install --config Release
