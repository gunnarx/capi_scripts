#!/bin/bash -xe

cd "$(dirname "$0")"
WORKDIR=$PWD
. ./config.sh

d=./franca_ara_integration
GCC_ARCH=x86_64-linux-gnu
sysroot="$SYSROOT"
[ -z "$SYSROOT" ] && sysroot=/home/user/sysroot_x86_64

# Note qmake from host root
qmake=/usr/lib/$GCC_ARCH/qt5/bin/qmake

cd "$d"
git checkout no_dlt
fgrep -q $sysroot src/src.pro || echo "LIBS += -L\"$sysroot/usr/lib\"" >> src/src.pro
export PREFIX=$sysroot/usr
$qmake franca_ara.pro
make -j4

sudo cp franca-ara $sysroot/usr/bin/

# Build test server for dev support
CXX=$GCC_ARCH-g++

cd tests/testprograms/capi_server
$CXX -o capi_server -std=c++14 -I src-gen -I/usr/local/include/CommonAPI-3.1 \
  main.cpp \
    src-gen/v1/genivi/aasr/showcase/*.cpp \
    -L$sysroot/usr/lib \
    -lCommonAPI-SomeIP  \
    -lCommonAPI \
    -lpthread \
    -lvsomeip

sudo cp capi_server $sysroot/usr/bin/
