#!/bin/bash
chmod +x configure

./configure \
     -shared \
     -release \
     -prefix $PREFIX \
     -extprefix $PREFIX \
     -hostprefix $PREFIX \
     -L $PREFIX/lib \
     -I $PREFIX/include \
     -confirm-license \
     -no-fontconfig \
     -no-separate-debug-info \
     -no-warnings-are-errors \
     -nomake examples \
     -nomake tests \
     -no-warnings-are-errors \
     -opengl desktop \
     -opensource \
     -verbose

make -j$CPU_COUNT
make install
