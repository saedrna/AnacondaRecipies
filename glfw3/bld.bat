@echo on

mkdir build
cd build

cmake -GNinja                              ^
 -DBUILD_SHARED_LIBS=ON                    ^
 -DLIB_SUFFIX=                             ^
 -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
 -DUSE_MSVC_RUNTIME_LIBRARY_DLL=1          ^
 -DGLFW_BUILD_EXAMPLES=0                   ^
 -DGLFW_BUILD_TESTS=0                      ^
 -DGLFW_BUILD_DOCS=0                       ^
 ../

cmake --build . --target install --config Release

exit 0
