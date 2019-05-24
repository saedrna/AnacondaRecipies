make -j$CPU_COUNT

if [[ $(uname) == "Linux" ]]; then
    cd build
    cd linux_intel64_gcc_cc7_libc2.27_kernel4.15.0_release

    cp ./libtbb.so.2 $PREFIX/lib
    ln $PREFIX/lib/libtbb.so.2 $PREFIX/lib/libtbb.so

    cp ./libtbbmalloc.so.2 $PREFIX/lib
    ln $PREFIX/lib/libtbb.so.2 $PREFIX/lib/libtbbmalloc.so

    cp ./libtbbmalloc_proxy.so.2 $PREFIX/lib
    ln $PREFIX/lib/libtbbmalloc_proxy.so.2 $PREFIX/lib/libtbbmalloc_proxy.so
else
    cd build
    cd macos_intel64_clang_cc4.0.1_os10.14.5_release

    cp ./libtbb.dylib $PREFIX/lib
    cp ./libtbbmalloc.dylib $PREFIX/lib
    cp ./libtbbmalloc_proxy.dylib $PREFIX/lib
fi

cd ..
cd ..

mkdir -p $PREFIX/include
cd include 
cp -r ./tbb $PREFIX/include
cp -r ./serial $PREFIX/include
