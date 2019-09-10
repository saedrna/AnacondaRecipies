@echo ON
setlocal enabledelayedexpansion

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

rmdir %SRC_DIR%\src\third_party\ceres-solver /s /q
rmdir %SRC_DIR%\src\third_party\cxsparse /s /q
rmdir %SRC_DIR%\src\third_party\eigen /s /q
rmdir %SRC_DIR%\src\third_party\flann /s /q
rmdir %SRC_DIR%\src\third_party\jpeg /s /q
rmdir %SRC_DIR%\src\third_party\lemon /s /q
rmdir %SRC_DIR%\src\third_party\png /s /q
rmdir %SRC_DIR%\src\third_party\tiff /s /q
rmdir %SRC_DIR%\src\third_party\zlib /s /q

cmake -G "Ninja" ^
        -DCMAKE_BUILD_TYPE=Release ^
        -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
        -DOpenMVG_BUILD_SHARED=ON ^
        -DOpenMVG_BUILD_DOC=OFF ^
        -DOpenMVG_BUILD_EXAMPLES=OFF ^
        -DOpenMVG_BUILD_SOFTWARES=ON ^
        -DOpenMVG_BUILD_GUI_SOFTWARES=OFF ^
        -DEIGEN_INCLUDE_DIR_HINTS=%UNIX_LIBRARY_PREFIX%/include/eigen3 ^
        -DCERES_DIR_HINTS=%UNIX_LIBRARY_PREFIX%/ceres ^
        -DFLANN_INCLUDE_DIR_HINTS=%UNIX_LIBRARY_PREFIX%/flann ^
        -DLEMON_INCLUDE_DIR_HINTS=%UNIX_LIBRARY_PREFIX%/include/lemon ^
        -DCOINUTILS_INCLUDE_DIR_HINTS=%UNIX_LIBRARY_PREFIX%/include/coin ^
        -DCLP_INCLUDE_DIR_HINTS=%UNIX_LIBRARY_PREFIX%/include/coin ^
        -DOSI_INCLUDE_DIR_HINTS=%UNIX_LIBRARY_PREFIX%/include/coin ^
        -DOpenMVG_USE_INTERNAL_CLP=OFF ^
        -DOpenMVG_USE_INTERNAL_COINUTILS=OFF ^
        -DOpenMVG_USE_INTERNAL_OSI=OFF ^
        -DOpenMVG_USE_INTERNAL_EIGEN=OFF ^
        -DOpenMVG_USE_INTERNAL_CEREAL=OFF ^
        -DOpenMVG_USE_INTERNAL_CERES=OFF ^
        -DOpenMVG_USE_INTERNAL_FLANN=OFF ^
        -DFLANN_LIBRARY=%UNIX_LIBRARY_PREFIX%/lib/flann_cpp_s.lib ^
        -DJPEG_LIBRARY_RELEASE=%UNIX_LIBRARY_PREFIX%/lib/jpeg-static.lib ^
        -DTARGET_ARCHITECTURE=core ^
        ../src 

if errorlevel 1 exit 1
cmake --build . --target install --config Release

exit 0
