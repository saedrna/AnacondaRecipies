mkdir build 
cd build

:: CMake/OpenCV like Unix-style paths for some reason.
set UNIX_PREFIX=%PREFIX:\=/%
set UNIX_LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set UNIX_LIBRARY_BIN=%LIBRARY_BIN:\=/%
set UNIX_LIBRARY_INC=%LIBRARY_INC:\=/%
set UNIX_LIBRARY_LIB=%LIBRARY_LIB:\=/%
set UNIX_SP_DIR=%SP_DIR:\=/%
set UNIX_SRC_DIR=%SRC_DIR:\=/%

cmake -LAH -G "Ninja" ^
  -DCMAKE_PREFIX_PATH=%UNIX_LIBRARY_PREFIX% ^
  -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DWITH_CGAL_ImageIO=OFF ^
  -DWITH_CGAL_Qt5=OFF ^
  -DCGAL_HEADER_ONLY=ON ^
  .. 

if errorlevel 1 exit /b 1

cmake --build . --target install --config Release
if errorlevel 1 exit /b 1

del %LIBRARY_PREFIX%\lib\cmake\CGAL\FindBLAS.cmake
del %LIBRARY_PREFIX%\lib\cmake\CGAL\FindLAPACK.cmake

exit 0
