#!/bin/bash
# Clean config for dirty builds
# -----------------------------
rm -f .qmake.stash .qmake.cache || true

# Compile
# -------
chmod +x configure

# Remove the full path from CXX etc. If we don't do this
# then the full path at build time gets put into 
# mkspecs/qmodule.pri and qmake attempts to use this.
export AR=$(basename ${AR})
export RANLIB=$(basename ${RANLIB})
export STRIP=$(basename ${STRIP})
export OBJDUMP=$(basename ${OBJDUMP})
export CC=$(basename ${CC})
export CXX=$(basename ${CXX})

# Let Qt set its own flags and vars
for x in OSX_ARCH CFLAGS CXXFLAGS LDFLAGS
do
    unset $x
done

MAKE_JOBS=$CPU_COUNT
# You can use this to cut down on the number of modules built. Of course the Qt package will not be of
# much use, but it is useful if you are iterating on e.g. figuring out compiler flags to reduce the
# size of the libraries.
MINIMAL_BUILD=no

if ! which ruby > /dev/null 2>&1; then
     echo "You need ruby to build qtwebkit"
     exit 1
fi

ln -s ${GXX} g++ || true
ln -s ${GCC} gcc || true
# Needed for -ltcg, it we split build and host again, change to ${BUILD_PREFIX}
ln -s ${BUILD_PREFIX}/bin/${HOST}-gcc-ar gcc-ar || true
chmod +x g++ gcc gcc-ar
export PATH=${PWD}:${PATH}
export LD=${GXX}
export CC=${GCC}
export CXX=${GXX}

declare -a INCDIRS
INCDIRS=(-I ${PREFIX}/include)
SYSINCDIRS=$(echo "" | ${CXX} -xc++ -E -v - 2>&1 | awk '/#include <...> search starts here:/{flag=1;next}/End of search list./{flag=0}flag')
for SYSINCDIR in ${SYSINCDIRS}; do
    INCDIRS+=(-I ${SYSINCDIR})
done

export PATH=${PWD}:${PATH}
declare -a SKIPS

./configure -prefix $PREFIX \
            -libdir $PREFIX/lib \
            -bindir $PREFIX/bin \
            -headerdir $PREFIX/include/qt \
            -archdatadir $PREFIX \
            -datadir $PREFIX \
            -L $PREFIX/lib \
            "${INCDIRS[@]}" \
            -release \
            -opensource \
            -confirm-license \
            -shared \
            -nomake examples \
            -nomake tests \
            -verbose \
            -skip wayland \
            -qt-xcb \
            -qt-xkbcommon \
            -xkb-config-root $PREFIX/lib \
            -dbus \
            -reduce-relocations \
            -cups \
            -Wno-expansion-to-defined \
            -opengl desktop


make -j$CPU_COUNT
make install
