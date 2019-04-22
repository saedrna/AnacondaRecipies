#!/bin/bash

./configure --prefix=$PREFIX --with-curl=no --with-xml2=no

make -j$CPU_COUNT
make install
