#!/bin/bash

chmod +x configure

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

make -j$CPU_COUNT
make install
