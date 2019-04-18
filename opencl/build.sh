sed -i.bak  "s|/etc/OpenCL/vendors/|$PREFIX/etc/OpenCL/vendors/|g" icd_linux.c;

mkdir build
cd build

cmake -DCMAKE_INSTALL_PREFIX=$PREFIX ..
make -j${CPU_COUNT}
make install

if [[ "$(uname)" == "Darwin" ]]; then
    ln -s $PREFIX/include/CL $PREFIX/include/OpenCL
fi
