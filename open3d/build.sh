if [[ $(uname) == "Linux" ]]; then
    export LDFLAGS="$LDFLAGS -Wl,-rpath,$BUILD_PREFIX/lib -Wl,-rpath-link,$BUILD_PREFIX/lib -L$BUILD_PREFIX/lib"
fi

cp -R "$SRC_DIR/include" "$PREFIX"
cp -R "$SRC_DIR/lib" "$PREFIX"
