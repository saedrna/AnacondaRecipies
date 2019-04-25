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

qmake CONFIG+=release
make all -j$CPU_COUNT
make install
