#!/bin/bash

meson setup build \
    --prefix=$PREFIX \
    --libdir=$PREFIX/lib \
    -Denable-x11=false \
    -Denable-wayland=false \
    -Denable-docs=false 

ninja -C build
ninja -C build install
