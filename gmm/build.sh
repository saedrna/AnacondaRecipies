#!/bin/bash
if [[ $(uname) == "Linux" ]]; then
    export CXX=${HOST}-g++
    export CC=${HOST}-gcc
else
    export CXX="g++"
    export CC="gcc"
fi

./configure --prefix=${PREFIX}
make
make install
