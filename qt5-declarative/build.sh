#!/bin/bash
if [[ $(uname) == "Linux" ]]; then
    ln -s $BUILD_PREFIX/bin/${HOST}-g++ $BUILD_PREFIX/bin/g++ || true
    ln -s $BUILD_PREFIX/bin/${HOST}-gcc $BUILD_PREFIX/bin/gcc || true
    ln -s $BUILD_PREFIX/bin/${HOST}-gcc-ar $BUILD_PREFIX/bin/gcc-ar || true

    declare -a INCDIRS
    INCDIRS+=(INCLUDEPATH+=$BUILD_PREFIX/$HOST/sysroot/usr/include)
    # "${INCDIRS[@]}"
    qmake CONFIG+=release 
else
    qmake CONFIG+=release
fi
make all -j$CPU_COUNT
make install
