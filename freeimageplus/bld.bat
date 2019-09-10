mkdir buildd
cd buildd

REM Configure step
cmake -GNinja ^
 -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DCMAKE_SYSTEM_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DOCE_WIN_BUNDLE_INSTALL_DIR="%LIBRARY_PREFIX%" ^
 -DBUNDLE_BUILD_FREEIMAGE=ON ^
 -DBUNDLE_BUILD_FREETYPE=OFF ^
 -DBUNDLE_BUILD_GL2PS=OFF ^
 -DBUNDLE_SHARED_LIBRARIES=ON ^
 -DOCE_MULTITHREAD_LIBRARY=OpenMP ^
 ../
if errorlevel 1 exit 1

REM Install step
cmake --build . --target install --config Release
if errorlevel 1 exit 1

REM fix non-standard include location
copy "%LIBRARY_PREFIX%"\include\FreeImage\FreeImage.h "%LIBRARY_PREFIX%"\include
copy "%LIBRARY_PREFIX%"\include\FreeImage\FreeImagePlus.h "%LIBRARY_PREFIX%"\include
rmdir /S /Q "%LIBRARY_PREFIX%"\include\FreeImage

exit 0