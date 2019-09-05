#!/bin/bash

set -ex
if [ "$(uname)" == "Linux" ]
then
   export LDFLAGS="$LDFLAGS -Wl,-rpath-link,${PREFIX}/lib"
fi


cmake -G "Unix Makefiles" \
      -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
      -DCMAKE_BUILD_TYPE:STRING=Release \
      -DCMAKE_LIBRARY_PATH="${PREFIX}/lib" \
      -DCMAKE_INCLUDE_PATH="${PREFIX}/include" \
      -DWITH_TESTS=OFF

# CircleCI offers two cores.
make -j $CPU_COUNT
make install
