mkdir build_vs
cd build_vs

:: Had to set TIFF_NAMES, PROJ4_NAMES and JPEG_NAMES to force use of shared libs
:: Note that zlib and jpeg only get linked in if tiff is linked statically, otherwise
:: they don't seem to be used (presumeably they are used via libtiff in a dll build).
set UNIX_PREFIX=%PREFIX:\=/%
set UNIX_LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set UNIX_LIBRARY_BIN=%LIBRARY_BIN:\=/%
set UNIX_LIBRARY_INC=%LIBRARY_INC:\=/%
set UNIX_LIBRARY_LIB=%LIBRARY_LIB:\=/%
set UNIX_SP_DIR=%SP_DIR:\=/%
set UNIX_SRC_DIR=%SRC_DIR:\=/%

cmake -GNinja ^
      -DBUILD_SHARED_LIBS=ON ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_PREFIX_PATH=%UNIX_LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
      -DWITH_ZLIB=ON ^
      -DWITH_JPEG=ON ^
      -DWITH_TIFF=ON ^
      -DTIFF_NAMES=tiff ^
      -DPROJ_NAMES=proj_6_0 ^
      -DJPEG_NAMES=jpeg-static ^
      -DJPEG_LIBRARY_RELEASE=%UNIX_LIBRARY_PREFIX%/lib/jpeg-static.lib ^
      ../
if errorlevel 1 exit 1

cmake --build . --target install --config Release
if errorlevel 1 exit 1

exit 0
