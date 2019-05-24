mkdir build
cd build

echo "#define GEOS_SVN_REVISION 4298" > geos_svn_revision.h

if [[ $(uname) == "Linux" ]]; then
cmake -GNinja \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -Wno-deprecated-declarations -Wno-misleading-indentation" \
      ../
else
cmake -GNinja \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON \
      ../
fi
cmake --build . --target install --config Release
