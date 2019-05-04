mkdir build
cd build

set UNIX_PREFIX=%PREFIX:\=/%
set UNIX_LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set UNIX_LIBRARY_BIN=%LIBRARY_BIN:\=/%
set UNIX_LIBRARY_INC=%LIBRARY_INC:\=/%
set UNIX_LIBRARY_LIB=%LIBRARY_LIB:\=/%
set UNIX_SP_DIR=%SP_DIR:\=/%
set UNIX_SRC_DIR=%SRC_DIR:\=/%

cmake -GNinja ^
	  -DBUILD_SHARED_LIBS=ON ^
	  -DCMAKE_BUILD_TYPE="Release" ^
      -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
      -DCMAKE_PREFIX_PATH=%UNIX_LIBRARY_PREFIX% ^
	  -DOIIO_BUILD_TOOLS=OFF ^
	  -DOIIO_BUILD_TESTS=OFF ^
	  -DJPEG_LIBRARY=%UNIX_LIBRARY_PREFIX%/lib/jpeg-static.lib ^
      -DHIDE_SYMBOLS=ON ^
      -DUSE_DICOM=OFF ^
      -DUSE_FFMPEG=OFF ^
      -DUSE_FIELD3D=OFF ^
      -DUSE_FREETYPE=OFF ^
      -DUSE_GIF=OFF ^
      -DUSE_NUKE=OFF ^
      -DUSE_OCIO=OFF ^
      -DUSE_OPENCV=OFF ^
      -DUSE_OPENJPEG=OFF ^
      -DUSE_OPENSSL=OFF ^
      -DUSE_PTEX=OFF ^
      -DUSE_PYTHON=OFF ^
      -DUSE_QT=OFF ^
      -DUSE_WEBP=OFF ^
      -DBUILDSTATIC=OFF ^
      -DBUILD_MISSING_PYBIND11=OFF ^
      -DBUILD_MISSING_DEPS=OFF ^
      -DCMAKE_DISABLE_FIND_PACKAGE_Git=OFF ^
      -DVERBOSE=ON ^
      -DBUILD_PYBIND11_FORCE=OFF ^
	  ../
if errorlevel 1 exit 1

cmake --build . --target install --config Release
if errorlevel 1 exit 1

exit 0