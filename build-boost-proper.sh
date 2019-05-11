#!/bin/bash -xe

cd "$(dirname "$0")"
WORKDIR=$PWD
. ./config.sh

b=./boost_1_67_0

sysroot="$SYSROOT"
[ -z "$SYSROOT" ] && sysroot=/home/user/sysroot_x86_64

cd "$b"
unset CC # Avoid SDK settings - build bootstrap with host compiler
./bootstrap.sh

. /xdt/sdk/environment-setup-corei7-64-agl-linux # Restore SDK env

sed -i "s/using gcc/using gcc : arm : $GCC_ARCH-g++/" project-config.jam

./b2 --with-thread --with-system --with-log
sudo ./b2 --with-thread --with-system --with-log --prefix=$sysroot/usr  install

#./b2 install --prefix=PREFIX

