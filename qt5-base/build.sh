#!/bin/bash

chmod +x configure

if [[ ${HOST} =~ .*linux.* ]]; then
# Horrible hack! We should not `conda install` in build.sh!!!
mkdir -p "${SRC_DIR}/openssl_hack"
conda install --channel conda-forge \
                --no-deps --yes --copy --prefix "${SRC_DIR}/openssl_hack" \
                openssl=${openssl}

export OPENSSL_LIBS="-L${SRC_DIR}/openssl_hack/lib -lssl -lcrypto"

rm -rf ${PREFIX}/include/openssl

./configure -prefix $PREFIX \
            -libdir $PREFIX/lib \
            -bindir $PREFIX/bin \
            -headerdir $PREFIX/include/qt \
            -archdatadir $PREFIX \
            -datadir $PREFIX \
            -L $PREFIX/lib \
            -I $PREFIX/include \
            -I ${SRC_DIR}/openssl_hack/include \
            -release \
            -opensource \
            -confirm-license \
            -shared \
            -nomake examples \
            -nomake tests \
            -verbose \
            -system-xcb \
            -xkbcommon \
            -Wno-expansion-to-defined \
            -openssl \
            -openssl-linked \
            -opengl desktop
else
./configure -prefix $PREFIX \
            -libdir $PREFIX/lib \
            -bindir $PREFIX/bin \
            -headerdir $PREFIX/include/qt \
            -archdatadir $PREFIX \
            -datadir $PREFIX \
            -L $PREFIX/lib \
            -I $PREFIX/include \
            -I ${SRC_DIR}/openssl_hack/include \
            -release \
            -opensource \
            -confirm-license \
            -shared \
            -nomake examples \
            -nomake tests \
            -verbose \
            -Wno-expansion-to-defined \
            -openssl \
            -openssl-linked \
            -opengl desktop
fi

make -j$CPU_COUNT
make install
