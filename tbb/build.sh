make -j$CPU_COUNT

cd build
cd linux_intel64_gcc_cc7_libc2.27_kernel4.15.0_release

cp ./libtbb.so.2 $PREFIX/lib
ln $PREFIX/lib/libtbb.so.2 $PREFIX/lib/libtbb.so

cp ./libtbbmalloc.so.2 $PREFIX/lib
ln $PREFIX/lib/libtbb.so.2 $PREFIX/lib/libtbbmalloc.so

cp ./libtbbmalloc_proxy.so.2 $PREFIX/lib
ln $PREFIX/lib/libtbbmalloc_proxy.so.2 $PREFIX/lib/libtbbmalloc_proxy.so

cd ..
cd ..

mkdir $PREFIX/include
cd include 
cp -r ./tbb $PREFIX/include
cp -r ./serial $PREFIX/include
