#!/bin/sh

set -eu

rm -rf AppDir
mkdir AppDir
export APPIMAGE_EXTRACT_AND_RUN=1
./linuxdeploy*.AppImage -e /usr/local/bin/scrcpy --desktop-file $SRC_ROOT/scrcpy.desktop --icon-file $SRC_ROOT/scrcpy.png --appdir=AppDir --library=/usr/lib/libc.so.6 --library=/usr/lib64/ld-linux-x86-64.so.2 --custom-apprun=$SRC_ROOT/AppRun -lavformat

cp $BUILD_DIR/app/scrcpy AppDir/usr/bin/.
cp $ADB_DIR/adb AppDir/usr/bin/.

cp $BUILD_DIR/../LICENSE AppDir/.
echo $(git describe --tags) > AppDir/VERSION.txt

mkdir -p AppDir/usr/local/share/scrcpy
cp $BUILD_DIR/../scrcpy_server AppDir/usr/local/share/scrcpy/scrcpy-server

./appimage*.AppImage AppDir -s AppDir/usr/share/applications/scrcpy.desktop -l -o
