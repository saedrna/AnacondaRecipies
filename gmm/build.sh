#!/bin/bash

export CXX="g++"
export CC="gcc"

./configure --prefix=${PREFIX}
make
make install
