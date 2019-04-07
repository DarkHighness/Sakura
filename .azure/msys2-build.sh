#!/bin/bash

set -e

#cd %SRC_DIR%

qmake -Wall -Wlogic -Wparser CONFIG+=release
mingw32-make.exe
ls release
mkdir package
mv release/sakura.exe package
mv sarasa-mono-sc-regular.ttf package
cd package
windeployqt --qmldir %CD:~0,2%\msys64\mingw64\share\qt5\qml \
     --release --no-patchqt --libdir ./libs \
    --plugindir ./plugins sakura.exe
7z -tZip a sakura.zip ./package/* -mx9