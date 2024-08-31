@echo off
setlocal
set PATH=%~dp0Tools\mingw1120_64\bin;%PATH%

cd /D "%~dp0" || exit /B 1

if not exist "%~dp0Build\Protobuf.MinGWDebug\_temp" mkdir "%~dp0Build\Protobuf.MinGWDebug\_temp"
cd /D "%~dp0Build\Protobuf.MinGWDebug\_temp" || exit /B 1

cmake -G "MinGW Makefiles" ^
    -DCMAKE_BUILD_TYPE=Debug ^
    -DCMAKE_INSTALL_PREFIX:PATH="%~dp0Build\Protobuf.MinGWDebug" ^
    -DBUILD_SHARED_LIBS=TRUE ^
    -Dprotobuf_BUILD_SHARED_LIBS=TRUE ^
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
