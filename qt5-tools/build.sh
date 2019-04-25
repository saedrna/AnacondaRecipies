#!/bin/bash

# Remove the full path from CXX etc. If we don't do this
# then the full path at build time gets put into 
# mkspecs/qmodule.pri and qmake attempts to use this.
export AR=$(basename ${AR})
export RANLIB=$(basename ${RANLIB})
export STRIP=$(basename ${STRIP})
export OBJDUMP=$(basename ${OBJDUMP})
export CC=$(basename ${CC})
export CXX=$(basename ${CXX})

ln -s ${GXX} g++ || true
ln -s ${GCC} gcc || true
# Needed for -ltcg, it we split build and host again, change to ${BUILD_PREFIX}
ln -s ${BUILD_PREFIX}/bin/${HOST}-gcc-ar gcc-ar || true
chmod +x g++ gcc gcc-ar
export PATH=${PWD}:${PATH}
export LD=${GXX}
export CC=${GCC}
export CXX=${GXX}

qmake CONFIG+=release
make all -j$CPU_COUNT
make install
