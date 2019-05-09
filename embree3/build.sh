# Make build directory
mkdir build
cd build

# Configure
cmake ../ \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_BUILD_TYPE=Release \
      -DEMBREE_TUTORIALS=OFF \
      -DEMBREE_ISPC_SUPPORT=OFF \
      -DEMBREE_TASKING_SYSTEM="INTERNAL" \
      -GNinja

# Compile
cmake --build . --target install --config Release

# remove tutorial models (which embree installed even when EMBREE_TUTORIALS=off)
# this is easier than patching embree's cmake
rm -rf ${PREFIX}/bin/models
