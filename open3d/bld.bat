@echo ON
setlocal enabledelayedexpansion

mkdir tinyfiledialogs
mkdir dirent
mkdir liblzf
mkdir rply
mkdir build
cd build

:: COPY the tinyfiledialogs into open3d dir
robocopy %RECIPE_DIR%\tinyfiledialogs %SRC_DIR%\tinyfiledialogs *.*
robocopy %RECIPE_DIR%\rply %SRC_DIR%\rply *.*
robocopy %RECIPE_DIR%\liblzf %SRC_DIR%\liblzf *.*
robocopy %RECIPE_DIR%\dirent %SRC_DIR%\dirent *.*

:: CMake/OpenCV like Unix-style paths for some reason.
set UNIX_PREFIX=%PREFIX:\=/%
set UNIX_LIBRARY_PREFIX=%LIBRARY_PREFIX:\=/%
set UNIX_LIBRARY_BIN=%LIBRARY_BIN:\=/%
set UNIX_LIBRARY_INC=%LIBRARY_INC:\=/%
set UNIX_LIBRARY_LIB=%LIBRARY_LIB:\=/%
set UNIX_SP_DIR=%SP_DIR:\=/%
set UNIX_SRC_DIR=%SRC_DIR:\=/%

:: cmake -LAH -G "Visual Studio 15 2017 Win64"


cmake -LAH -G "Ninja" ^
    -DCMAKE_BUILD_TYPE="Release" ^
    -DCMAKE_INSTALL_PREFIX=%UNIX_LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%UNIX_LIBRARY_PREFIX% ^
    -DBUILD_CPP_EXAMPLES=OFF ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBUILD_PYTHON_MODULE=OFF ^
    -DBUILD_PYBIND11=OFF ^
    -DENABLE_JUPYTER=OFF ^
    -DEIGEN3_FOUND=ON ^
    -Dpybind11_FOUND=OFF ^
    -DGLEW_FOUND=ON ^
    -DGLFW_FOUND=ON ^
    -DOPENGL_FOUND=ON ^
    -DJSONCPP_FOUND=ON ^
    -DPNG_FOUND=ON ^
    -DJPEG_FOUND=ON ^
    -Dtinyfiledialogs_FOUND=ON ^
    -DEIGEN3_INCLUDE_DIRS=%UNIX_LIBRARY_PREFIX%/include/eigen3 ^
    -DJSONCPP_INCLUDE_DIRS=%UNIX_LIBRARY_PREFIX%/include/json ^
    -DOTHER_INCLUDE_DIRS=%UNIX_LIBRARY_PREFIX%/include ^
    -DGLEW_LIBRARIES=%UNIX_LIBRARY_PREFIX%/lib/glew32.lib ^
    -DGLFW_LIBRARIES=%UNIX_LIBRARY_PREFIX%/lib/glfw3dll.lib ^
    -DJPEG_LIBRARIES=%UNIX_LIBRARY_PREFIX%/lib/jpeg-static.lib ^
    -DJSONCPP_LIBRARIES=%UNIX_LIBRARY_PREFIX%/lib/jsoncpp.lib ^
    -DPNG_LIBRARIES=%UNIX_LIBRARY_PREFIX%/lib/libpng16_static.lib ^
    -DZLIB_LIBRARIES=%UNIX_LIBRARY_PREFIX%/lib/zlibstatic.lib ^
    -Dflann_LIBRARIES=%UNIX_LIBRARY_PREFIX%/lib/flann_cpp_s.lib ^
    ..

if errorlevel 1 exit 1

cmake --build . --target install --config Release
if errorlevel 1 exit 1

exit 0