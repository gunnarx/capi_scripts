#!/bin/bash -xe

cd "$(dirname "$0")"
WORKDIR=$PWD
. ./config.sh

d=./vsomeip
GCC_ARCH=x86_64-linux-gnu
sysroot="$SYSROOT"
[ -z "$SYSROOT" ] && sysroot=/home/user/sysroot_x86_64

#export BOOST_ROOT=$sysroot/usr/share/boost/boost_1_67_0

cd "$d"
rm -rf build
mkdir build
cd build
cmake -D CMAKE_INSTALL_PREFIX=$sysroot \
      -D BOOST_ROOT=$sysroot/usr/share/boost/boost_1_67_0 \
      -D CMAKE_TOOLCHAIN_FILE=$WORKDIR/CMakeToolChain.txt ..

cd ..
set +e

[ -f ../0001-Support-boost-v1.66.patch ] && pfile=../0001-Support-boost-v1.66.patch
[ -f ~/0001-Support-boost-v1.66.patch ] && pfile=~/0001-Support-boost-v1.66.patch

patch --forward -p1 <"$pfile"
set -e
cd build
make -j4
sudo make install

