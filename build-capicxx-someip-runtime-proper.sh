#!/bin/bash -xe

cd "$(dirname "$0")"
WORKDIR=$PWD
. ./config.sh

d=./capicxx-someip-runtime
sysroot="$SYSROOT"
[ -z "$SYSROOT" ] && sysroot=/home/user/sysroot_x86_64

export PKG_CONFIG_PATH="$sysroot/usr/lib/pkgconfig"

cd "$d"
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=$sysroot \
      -D USE_INSTALLED_COMMONAPI=ON \
      -D CMAKE_TOOLCHAIN_FILE=$WORKDIR/CMakeToolChain.txt ..

make -j4
sudo make install

