@echo off
setlocal
set EMSCRIPTEN=%~dp0Tools\emsdk
set PATH=%EMSCRIPTEN%\upstream\emscripten;%~dp0Tools\python;%~dp0Tools\mingw1120_64\bin;%PATH%

if not exist %EMSCRIPTEN%\emsdk.bat git submodule update --init --recursive || exit /B 1

cd /D %EMSCRIPTEN% || exit /B 1
call emsdk.bat install 3.1.50 || exit /B 1
call emsdk.bat activate 3.1.50 || exit /B 1

cd /D %EMSCRIPTEN% || exit /B 1
set EMSDK_QUIET=1
call emsdk_env.bat || exit /B 1

if not exist "%~dp0Build\Protobuf.HTML5\_temp" mkdir "%~dp0Build\Protobuf.HTML5\_temp"
cd /D "%~dp0Build\Protobuf.HTML5\_temp" || exit /B 1

cmake -G "MinGW Makefiles" ^
    -DCMAKE_TOOLCHAIN_FILE:PATH="%EMSCRIPTEN%\upstream\emscripten\cmake\Modules\Platform\Emscripten.cmake" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX:PATH="%~dp0Build\Protobuf.HTML5" ^
    -DBUILD_SHARED_LIBS=FALSE ^
    -Dprotobuf_BUILD_SHARED_LIBS=FALSE ^
    -Dprotobuf_BUILD_TESTS=FALSE ^
    -Dprotobuf_BUILD_LIBUPB=FALSE ^
    -Dprotobuf_DISABLE_RTTI=TRUE ^
    -Dprotobuf_USE_UNITY_BUILD=TRUE ^
    -Dprotobuf_WITH_ZLIB=FALSE ^
    -Dprotobuf_ABSL_PROVIDER=FALSE ^
    -Dutf8_range_ENABLE_TESTS=FALSE ^
    -DABSL_PROPAGATE_CXX_STD=TRUE ^
    -DABSL_ENABLE_INSTALL=TRUE ^
    -DABSL_FIND_GOOGLETEST=FALSE ^
    "%~dp0Protobuf"
if errorlevel 1 exit /B 1

cmake --build . --target install --parallel 4 || exit /B 1
