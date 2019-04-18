#!/bin/bash

cp -f "${RECIPE_DIR}/SuiteSparse_config.mk" SuiteSparse_config/SuiteSparse_config.mk

if [ "$(uname)" == "Darwin" ]
then
    export LIBRARY_SEARCH_VAR=DYLD_FALLBACK_LIBRARY_PATH
    DYNAMIC_EXT=".dylib"
else
    export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH
    DYNAMIC_EXT=".so"
fi

export INCLUDE_PATH="${PREFIX}/include"
export LIBRARY_PATH="${PREFIX}/lib"

export INSTALL_LIB="${PREFIX}/lib"
export INSTALL_INCLUDE="${PREFIX}/include"

export BLAS="-lopenblas"
export LAPACK="-lopenblas"

# export environment variable so SuiteSparse will use the METIS built above
export MY_METIS_LIB="-L${PREFIX}/lib -lmetis"

# (optional) write out various make variables for easier build debugging
eval ${LIBRARY_SEARCH_VAR}="${PREFIX}/lib" make config 2>&1 | tee make_config.txt

# make SuiteSparse
eval ${LIBRARY_SEARCH_VAR}="${PREFIX}/lib" make -j1
make install

# manually install the static libraries
cp ${SRC_DIR}/AMD/Lib/libamd.a ${PREFIX}/lib
cp ${SRC_DIR}/BTF/Lib/libbtf.a ${PREFIX}/lib
cp ${SRC_DIR}/CAMD/Lib/libcamd.a ${PREFIX}/lib
cp ${SRC_DIR}/CCOLAMD/Lib/libccolamd.a ${PREFIX}/lib
cp ${SRC_DIR}/CHOLMOD/Lib/libcholmod.a ${PREFIX}/lib
cp ${SRC_DIR}/COLAMD/Lib/libcolamd.a ${PREFIX}/lib
cp ${SRC_DIR}/CSparse/Lib/libcsparse.a ${PREFIX}/lib
cp ${SRC_DIR}/CXSparse/Lib/libcxsparse.a ${PREFIX}/lib
cp ${SRC_DIR}/KLU/Lib/libklu.a ${PREFIX}/lib
cp ${SRC_DIR}/LDL/Lib/libldl.a ${PREFIX}/lib
cp ${SRC_DIR}/RBio/Lib/librbio.a ${PREFIX}/lib
cp ${SRC_DIR}/SPQR/Lib/libspqr.a ${PREFIX}/lib
cp ${SRC_DIR}/SuiteSparse_config/libsuitesparseconfig.a ${PREFIX}/lib
cp ${SRC_DIR}/UMFPACK/Lib/libumfpack.a ${PREFIX}/lib
