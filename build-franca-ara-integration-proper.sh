#!/bin/bash -xe

cd "$(dirname "$0")"
WORKDIR=$PWD
. ./config.sh

d=./franca_ara_integration
GCC_ARCH=x86_64-linux-gnu
sysroot="$SYSROOT"
[ -z "$SYSROOT" ] && sysroot=/home/user/sysroot_x86-64

# Note qmake from host root
qmake=/usr/lib/$GCC_ARCH/qt5/bin/qmake

cd "$d"
export PREFIX=$sysroot/usr
$qmake franca_ara.pro
make -j4

sudo cp franca-ara $sysroot/usr/bin/franca-ara

