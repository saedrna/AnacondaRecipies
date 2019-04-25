set CL=/MP

nmake /f makefile.vc WIN64=YES MSVC_VER=1910 ^
    GDAL_HOME=%LIBRARY_PREFIX% ^
    BINDIR=%LIBRARY_BIN% ^
    LIBDIR=%LIBRARY_LIB% ^
    INCDIR=%LIBRARY_INC% ^
    DATADIR=%LIBRARY_PREFIX%\share\gdal ^
    HTMLDIR=%LIBRARY_PREFIX%\share\doc\gdal 

if errorlevel 1 exit 1

mkdir -p %LIBRARY_PREFIX%\share\doc\gdal

nmake /f makefile.vc devinstall WIN64=YES MSVC_VER=1910  ^
    GDAL_HOME=%LIBRARY_PREFIX% ^
    BINDIR=%LIBRARY_BIN% ^
    LIBDIR=%LIBRARY_LIB% ^
    INCDIR=%LIBRARY_INC% ^
    DATADIR=%LIBRARY_PREFIX%\share\gdal ^
    HTMLDIR=%LIBRARY_PREFIX%\share\doc\gdal 

if errorlevel 1 exit 1

copy *.lib %LIBRARY_LIB%\ || exit 1

exit 0
