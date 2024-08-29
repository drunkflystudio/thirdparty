@echo off
setlocal
set EMSCRIPTEN=%~dp0Tools\emsdk
set PATH=%EMSCRIPTEN%\upstream\emscripten;%~dp0Tools\python;%~dp0Tools\mingw1120_64\bin;%PATH%

if not exist %EMSCRIPTEN%\emsdk.bat git submodule update --init --recursive || exit /B 1

cd /D %EMSCRIPTEN% || exit /B 1
call emsdk.bat install 3.1.50 || exit /B 1
call emsdk.bat activate 3.1.50 || exit /B 1

rem if not exist "%~dp0Build\MinGW64\bin\moc.exe" call "%~dp0QtBuildMinGW.cmd" || exit /B 1

if exist "%~dp0.mode-mingw" call "%~dp0QtClean.cmd" || exit /B 1
echo > "%~dp0.mode-html5" || exit /B 1

cd /D %EMSCRIPTEN% || exit /B 1
set EMSDK_QUIET=1
call emsdk_env.bat || exit /B 1

cd /D "%~dp0Qt" || exit /B 1
call configure ^
    -qt-host-path "%~dp0QtBin\msvc2019_64" ^
    --prefix="%~dp0Build\HTML5" ^
    --platform="wasm-emscripten" ^
    --confirm-license ^
    -disable-deprecated-up-to 0x060700 ^
    ^
    -no-warnings-are-errors ^
    --appstore-compliant=yes ^
    --ltcg=yes ^
    --optimize-size=yes ^
    --reduce-exports=no ^
    --release ^
    --static ^
    --unity-build ^
    ^
    --freetype=qt ^
    --harfbuzz=qt ^
    --libjpeg=no ^
    --openssl=no ^
    --zlib=qt ^
    --zstd=no ^
    ^
    --avx=no ^
    --avx2=no ^
    --avx512=no ^
    --sse2=no ^
    --sse3=no ^
    --sse4.1=no ^
    --sse4.2=no ^
    --ssse3=no ^
    ^
    --feature-buttongroup ^
    --feature-clipboard ^
    --feature-columnview ^
    --feature-completer ^
    --feature-concurrent ^
    --feature-datawidgetmapper ^
    --feature-dockwidget ^
    --feature-doubleconversion ^
    --feature-draganddrop ^
    --feature-formlayout ^
    --feature-future ^
    --feature-gc_binaries ^
    --feature-gestures ^
    --feature-graphicseffect ^
    --feature-imageformatplugin ^
    --feature-imageformat_bmp ^
    --feature-imageformat_jpeg ^
    --feature-imageformat_ppm ^
    --feature-imageformat_xbm ^
    --feature-imageformat_xpm ^
    --feature-image_heuristic_mask ^
    --feature-image_text ^
    --feature-inputdialog ^
    --feature-itemmodel ^
    --feature-jpeg ^
    --feature-label ^
    --feature-listwidget ^
    --feature-mimetype ^
    --feature-mimetype-database ^
    --feature-network ^
    --feature-optimize_full ^
    --feature-pcre2 ^
    --feature-png ^
    --feature-regularexpression ^
    --feature-rubberband ^
    --feature-settings ^
    --feature-sizegrip ^
    --feature-sortfilterproxymodel ^
    --feature-standarditemmodel ^
    --feature-style-stylesheet ^
    --feature-style-windows ^
    --feature-syntaxhighlighter ^
    --feature-tabletevent ^
    --feature-tablewidget ^
    --feature-textbrowser ^
    --feature-textedit ^
    --feature-texthtmlparser ^
    --feature-thread ^
    --feature-translation ^
    --feature-treewidget ^
    --feature-widgettextcontrol ^
    --feature-xml ^
    --feature-xmlstream ^
    --feature-xmlstreamreader ^
    --feature-xmlstreamwriter ^
    ^
    --no-feature-accessibility ^
    --no-feature-androiddeployqt ^
    --no-feature-animation ^
    --no-feature-backtrace ^
    --no-feature-calendarwidget ^
    --no-feature-cborstreamwriter ^
    --no-feature-commandlineparser ^
    --no-feature-commandlinkbutton ^
    --no-feature-concatenatetablesproxymodel ^
    --no-feature-ctf ^
    --no-feature-cxx17_filesystem ^
    --no-feature-datestring ^
    --no-feature-datetimeedit ^
    --no-feature-datetimeparser ^
    --no-feature-dbus ^
    --no-feature-dial ^
    --no-feature-direct2d ^
    --no-feature-direct2d1_1 ^
    --no-feature-directwrite ^
    --no-feature-directwrite3 ^
    --no-feature-dynamicgl ^
    --no-feature-easingcurve ^
    --no-feature-eglfs ^
    --no-feature-errormessage ^
    --no-feature-etw ^
    --no-feature-f16c ^
    --no-feature-filesystemiterator ^
    --no-feature-filesystemmodel ^
    --no-feature-filesystemwatcher ^
    --no-feature-fontcombobox ^
    --no-feature-fontdialog ^
    --no-feature-fscompleter ^
    --no-feature-gtk3 ^
    --no-feature-hijricalendar ^
    --no-feature-icu ^
    --no-feature-identityproxymodel ^
    --no-feature-im ^
    --no-feature-intelcet ^
    --no-feature-islamiccivilcalendar ^
    --no-feature-jalalicalendar ^
    --no-feature-journald ^
    --no-feature-keysequenceedit ^
    --no-feature-kms ^
    --no-feature-lcdnumber ^
    --no-feature-library ^
    --no-feature-macdeployqt ^
    --no-feature-mdiarea ^
    --no-feature-movie ^
    --no-feature-no_direct_extern_access ^
    --no-feature-pdf ^
    --no-feature-permissions ^
    --no-feature-picture ^
    --no-feature-printsupport ^
    --no-feature-process ^
    --no-feature-processenvironment ^
    --no-feature-progressdialog ^
    --no-feature-qmake ^
    --no-feature-scroller ^
    --no-feature-sessionmanager ^
    --no-feature-slog2 ^
    --no-feature-splashscreen ^
    --no-feature-sql ^
    --no-feature-stack-protector-strong ^
    --no-feature-systemsemaphore ^
    --no-feature-systemtrayicon ^
    --no-feature-testlib ^
    --no-feature-textdate ^
    --no-feature-textmarkdownreader ^
    --no-feature-textmarkdownwriter ^
    --no-feature-textodfwriter ^
    --no-feature-timezone ^
    --no-feature-toolbox ^
    --no-feature-transposeproxymodel ^
    --no-feature-undostack ^
    --no-feature-undocommand ^
    --no-feature-undogroup ^
    --no-feature-vkgen ^
    --no-feature-vulkan ^
    --no-feature-whatsthis ^
    --no-feature-wizard ^
    ^
    || exit /B 1

cmake --build . --config Release --target install --parallel 4 || exit /B 1

exit /B 0
