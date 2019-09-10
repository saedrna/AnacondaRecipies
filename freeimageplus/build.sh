#!/bin/bash

cp $RECIPE_DIR/Makefile.osx .

export CXXFLAGS="$CXXFLAGS -std=gnu++98"

# Build step 
make -j $CPU_COUNT
make install

