@echo ON
setlocal enabledelayedexpansion

set UNIX_PREFIX=%PREFIX:\=/%
set UNIX_LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set UNIX_LIBRARY_BIN=%LIBRARY_BIN:\=/%
set UNIX_LIBRARY_INC=%LIBRARY_INC:\=/%
set UNIX_LIBRARY_LIB=%LIBRARY_LIB:\=/%
set UNIX_SP_DIR=%SP_DIR:\=/%
set UNIX_SRC_DIR=%SRC_DIR:\=/%

xcopy /S/E/I "%SRC_DIR%/lib" "%UNIX_LIBRARY_PREFIX%/lib/"
xcopy /S/E/I "%SRC_DIR%/bin" "%UNIX_LIBRARY_PREFIX%/bin/"
xcopy /S/E/I "%SRC_DIR%/CMake" "%UNIX_LIBRARY_PREFIX%/cmake/"
xcopy /S/E/I "%SRC_DIR%/include" "%UNIX_LIBRARY_PREFIX%/include/"

if errorlevel 1 exit 1

exit 0