#!/bin/bash -xe

cd "$(dirname "$0")"
WORKDIR=$PWD
. ./config.sh

d=./capicxx-core-runtime
sysroot="$SYSROOT"
[ -z "$SYSROOT" ] && sysroot=/home/user/sysroot_x86_64

cd "$d"
rm -rf build
mkdir build
cd build
cmake -D CMAKE_INSTALL_PREFIX=$sysroot \
      -D CMAKE_TOOLCHAIN_FILE=$WORKDIR/CMakeToolChain.txt ..

make -j4
sudo make install

