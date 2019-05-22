#!/bin/bash

chmod +x configure

if [[ ${HOST} =~ .*linux.* ]]; then
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
            -system-xcb \
            -xkbcommon \
            -Wno-expansion-to-defined \
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
