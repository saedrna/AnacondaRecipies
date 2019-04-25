@echo off

cmake -G "Ninja" ^
   -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
   -DCMAKE_BUILD_TYPE=Release

if errorlevel 1 exit 1

cmake --build . --target install --config Release
if errorlevel 1 exit 1

exit 0