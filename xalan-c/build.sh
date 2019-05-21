cd c

export XERCESCROOT=${PREFIX}
export XALANCROOT=$(pwd)

if [ $(uname) == Darwin ]; then
    platform=macosx
    EXTRA_CXX_OPTIONS="-z -stdlib=libc++"
else
    platform=linux
fi

./runConfigure -p ${platform} -c cc -x c++ -b 64 -P ${PREFIX} ${EXTRA_CXX_OPTIONS}

make
make install
