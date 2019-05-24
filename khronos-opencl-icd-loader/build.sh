sed -i.bak  "s|/etc/OpenCL/vendors/|$PREFIX/etc/OpenCL/vendors/|g" icd_linux.c;

mkdir build
cd build

if [[ $(uname) == Darwin ]]; then
cmake -GNinja \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    ../
else
cmake -GNinja \
    -DCMAKE_AR=$BUILD_PREFIX/bin/$HOST-ar \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    ../
fi

cmake --build . --target install --config Release

if [[ "$(uname)" == "Darwin" ]]; then
    ln -s $PREFIX/include/CL $PREFIX/include/OpenCL
fi
