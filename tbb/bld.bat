cd build
cd vs2013

set CL=/MP

set SDK=%WindowsSDKVersion:~0,-1%

msbuild makefile.sln ^
    /p:Configuration=Release ^
    /p:Platform=x64 ^
    /p:WindowsTargetPlatformVersion=%SDK% ^
    /p:PlatformToolset=v141
    
if errorlevel 1 exit 1

robocopy %SRC_DIR%/build/vs2013/x64/Release %LIBRARY_PREFIX%/bin *.dll 
robocopy %SRC_DIR%/build/vs2013/x64/Release %LIBRARY_PREFIX%/lib *.lib
robocopy %SRC_DIR%/include %LIBRARY_PREFIX%/include /E

exit 0
