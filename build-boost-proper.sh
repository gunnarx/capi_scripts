#!/bin/bash -xe

cd "$(dirname "$0")"
WORKDIR=$PWD
. ./config.sh

b=./boost_1_67_0

sysroot="$SYSROOT"
[ -z "$SYSROOT" ] && sysroot=/home/user/sysroot_x86_64

cd "$b"
./bootstrap.sh

sed -i "s/using gcc/using gcc : arm : $GCC_ARCH-g++/" project-config.jam

./b2 --with-thread --with-system --with-log
sudo ./b2 --with-thread --with-system --with-log --prefix=$sysroot/usr  install

#./b2 install --prefix=PREFIX

