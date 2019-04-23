#!/bin/sh

CMAKE_GENERATOR="Unix Makefiles"

cmake -GNinja \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} 

cmake --build . --target install --config Release
