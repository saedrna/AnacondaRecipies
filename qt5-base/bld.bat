@echo on
setlocal EnableDelayedExpansion

:: See http://doc-snapshot.qt-project.org/qt5-5.4/windows-requirements.html
:: this needs to be CALLed due to an exit statement at the end of configure:
:: optimized-tools is necessary for qtlibinfix, otherwise:
:: qtbase/lib/Qt5Bootstrap.prl
:: ends up containing:
:: QMAKE_PRL_TARGET = Qt5Bootstrap.condad.lib
:: for some odd reason.
call configure ^
     -shared ^
     -release ^
     -prefix %LIBRARY_PREFIX% ^
     -extprefix %LIBRARY_PREFIX% ^
     -hostprefix %LIBRARY_PREFIX% ^
     -L %LIBRARY_LIB% ^
     -I %LIBRARY_INC% ^
     -confirm-license ^
     -no-fontconfig ^
     -no-separate-debug-info ^
     -no-warnings-are-errors ^
     -nomake examples ^
     -nomake tests ^
     -no-warnings-are-errors ^
     -opengl desktop ^
     -opensource ^
     -platform win32-msvc ^
     -verbose

if errorlevel 1 exit 1

:: re-enable echoing which is disabled by configure
echo on

:: To get a much quicker turnaround you can add this: (remember also to add the hat symbol after -plugin-sql-sqlite)
::     -skip %WEBBACKEND% -skip qtwebsockets -skip qtwebchannel -skip qtwayland -skip qtwinextras -skip qtsvg -skip qtsensors ^
::     -skip qtcanvas3d -skip qtconnectivity -skip declarative -skip multimedia -skip qttools

jom release
if errorlevel 1 exit 1

jom  install
if errorlevel 1 exit 1

robocopy %RECIPE_DIR% %LIBRARY_PREFIX%\plugins qtdeploy.ps1
robocopy %SRC_DIR%\bin %LIBRARY_PREFIX%\bin *.*

exit 0
