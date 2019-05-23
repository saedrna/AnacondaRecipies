#!/bin/bash

chmod +x configure

if [[ ${HOST} =~ .*linux.* ]]; then
# Let Qt set its own flags and vars
for x in OSX_ARCH CFLAGS CXXFLAGS LDFLAGS
do
    unset $x
done

ln -s ${GXX} $BUILD_PREFIX/bin/g++ || true
ln -s ${GCC} $BUILD_PREFIX/bin/gcc || true
ln -s $BUILD_PREFIX/bin/${HOST}-gcc-ar $BUILD_PREFIX/bin/gcc-ar || true

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
            -L $BUILD_PREFIX/$HOST/sysroot/usr/lib \
            -I $PREFIX/include \
            -I ${SRC_DIR}/openssl_hack/include \
            -release \
            -opensource \
            -confirm-license \
            -shared \
            -nomake examples \
            -nomake tests \
            -verbose \
            -qt-xcb \
            -xkbcommon \
            -Wno-expansion-to-defined \
            -openssl \
            -openssl-linked \
            -opengl desktop \
            -no-icu
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
