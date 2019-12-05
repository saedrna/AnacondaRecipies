#!/bin/bash

./configure --prefix=$PREFIX --with-curl=no --with-xml2=no --with-png=no

make -j$CPU_COUNT
make install
