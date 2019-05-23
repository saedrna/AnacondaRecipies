#!/bin/bash

chmod +x configure

if [[ ${HOST} =~ .*linux.* ]]; then
# Let Qt set its own flags and vars
# for x in OSX_ARCH CFLAGS CXXFLAGS LDFLAGS
# do
#     unset $x
# done

ln -s $BUILD_PREFIX/bin/${HOST}-g++ $BUILD_PREFIX/bin/g++ || true
ln -s $BUILD_PREFIX/bin/${HOST}-gcc $BUILD_PREFIX/bin/gcc || true
ln -s $BUILD_PREFIX/bin/${HOST}-gcc-ar $BUILD_PREFIX/bin/gcc-ar || true

# Horrible hack! We should not `conda install` in build.sh!!!
mkdir -p "${SRC_DIR}/openssl_hack"
conda install --channel conda-forge \
                --no-deps --yes --copy --prefix "${SRC_DIR}/openssl_hack" \
                openssl=${openssl}

export OPENSSL_LIBS="-L${SRC_DIR}/openssl_hack/lib -lssl -lcrypto"

rm -rf ${PREFIX}/include/openssl

declare -a INCDIRS
INCDIRS=(-I ${PREFIX}/include)
SYSINCDIRS=$(echo "" | ${CXX} -xc++ -E -v - 2>&1 | awk '/#include <...> search starts here:/{flag=1;next}/End of search list./{flag=0}flag')
for SYSINCDIR in ${SYSINCDIRS}; do
    INCDIRS+=(-I ${SYSINCDIR})
done
            # -extprefix $PREFIX \
            # -hostprefix $PREFIX \
            # -sysroot ${BUILD_PREFIX}/${HOST}/sysroot \
            # -L${BUILD_PREFIX}/${HOST}/sysroot/usr/lib64 \
            # "${INCDIRS[@]}" \
./configure -prefix $PREFIX \
            -libdir $PREFIX/lib \
            -bindir $PREFIX/bin \
            -headerdir $PREFIX/include/qt \
            -archdatadir $PREFIX \
            -datadir $PREFIX \
            -L$PREFIX/lib \
            -L${BUILD_PREFIX}/${HOST}/sysroot/usr/lib64 \
            -I$PREFIX/include \
            -I${SRC_DIR}/openssl_hack/include \
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
            -release \
            -opensource \
            -confirm-license \
            -shared \
            -nomake examples \
            -nomake tests \
            -verbose \
            -Wno-expansion-to-defined \
            -opengl desktop
fi

make -j$CPU_COUNT
make install
