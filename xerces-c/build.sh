#!/bin/bash

./configure --prefix=$PREFIX --with-icu
make -j${CPU_COUNT} ${VERBOSE_AT}
make check
make install
