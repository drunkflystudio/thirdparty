@echo off
setlocal
set PATH=%~dp0Tools\mingw1120_64\bin;%~dp0;%PATH%

if exist "%~dp0.mode-html5" call "%~dp0QtClean.cmd" || exit /B 1
echo > "%~dp0.mode-mingw" || exit /B 1

cd /D "%~dp0Qt" || exit /B 1
call configure ^
    -cmake-generator "MinGW Makefiles" ^
    --prefix="%~dp0Build\MinGW" ^
    --platform="win32-g++" ^
    --confirm-license ^
    -disable-deprecated-up-to 0x060700 ^
    ^
    --appstore-compliant=yes ^
    --ltcg=no ^
    --optimize-size=yes ^
    --reduce-exports=no ^
    --release ^
    --shared ^
    --unity-build ^
    ^
    --freetype=qt ^
    --harfbuzz=qt ^
    --openssl=no ^
    --zlib=qt ^
    --zstd=no ^
    ^
    --avx=yes ^
    --avx2=yes ^
    --avx512=yes ^
    --sse2=yes ^
    --sse3=yes ^
    --sse4.1=yes ^
    --sse4.2=yes ^
    --ssse3=yes ^
    ^
    --feature-accessibility ^
    --feature-buttongroup ^
    --feature-clipboard ^
    --feature-columnview ^
    --feature-commandlineparser ^
    --feature-completer ^
    --feature-concurrent ^
    --feature-datawidgetmapper ^
    --feature-direct2d ^
    --feature-direct2d1_1 ^
    --feature-directwrite ^
    --feature-directwrite3 ^
    --feature-dockwidget ^
    --feature-doubleconversion ^
    --feature-draganddrop ^
    --feature-dynamicgl ^
    --feature-filesystemiterator ^
    --feature-filesystemmodel ^
    --feature-filesystemwatcher ^
    --feature-formlayout ^
    --feature-fscompleter ^
    --feature-future ^
    --feature-gestures ^
    --feature-graphicseffect ^
    --feature-im ^
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
    --feature-library ^
    --feature-listwidget ^
    --feature-mimetype ^
    --feature-mimetype-database ^
    --feature-network ^
    --feature-optimize_full ^
    --feature-pcre2 ^
    --feature-png ^
    --feature-process ^
    --feature-processenvironment ^
    --feature-regularexpression ^
    --feature-rubberband ^
    --feature-settings ^
    --feature-sizegrip ^
    --feature-sortfilterproxymodel ^
    --feature-standarditemmodel ^
    --feature-style-stylesheet ^
    --feature-style-windows ^
    --feature-syntaxhighlighter ^
    --feature-systemsemaphore ^
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
    --no-feature-androiddeployqt ^
    --no-feature-animation ^
    --no-feature-backtrace ^
    --no-feature-calendarwidget ^
    --no-feature-cborstreamwriter ^
    --no-feature-commandlinkbutton ^
    --no-feature-concatenatetablesproxymodel ^
    --no-feature-ctf ^
    --no-feature-cxx17_filesystem ^
    --no-feature-datestring ^
    --no-feature-datetimeedit ^
    --no-feature-datetimeparser ^
    --no-feature-dbus ^
    --no-feature-dial ^
    --no-feature-easingcurve ^
    --no-feature-eglfs ^
    --no-feature-errormessage ^
    --no-feature-etw ^
    --no-feature-f16c ^
    --no-feature-fontcombobox ^
    --no-feature-fontdialog ^
    --no-feature-gc_binaries ^
    --no-feature-gtk3 ^
    --no-feature-hijricalendar ^
    --no-feature-icu ^
    --no-feature-identityproxymodel ^
    --no-feature-intelcet ^
    --no-feature-islamiccivilcalendar ^
    --no-feature-jalalicalendar ^
    --no-feature-journald ^
    --no-feature-keysequenceedit ^
    --no-feature-kms ^
    --no-feature-lcdnumber ^
    --no-feature-macdeployqt ^
    --no-feature-mdiarea ^
    --no-feature-movie ^
    --no-feature-pdf ^
    --no-feature-permissions ^
    --no-feature-picture ^
    --no-feature-printsupport ^
    --no-feature-progressdialog ^
    --no-feature-qmake ^
    --no-feature-scroller ^
    --no-feature-sessionmanager ^
    --no-feature-slog2 ^
    --no-feature-splashscreen ^
    --no-feature-sql ^
    --no-feature-stack-protector-strong ^
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
