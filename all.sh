#!/bin/sh -xe

cd "$(dirname "$0")"
WORKDIR=$PWD

. ./config.sh

clone() {
  d="$(basename "$1")"
  if [ ! -d $d ] ; then
    git clone $1
  fi
}

wget -c https://images.apertis.org/release/$APERTIS_RELEASE/$ARCH/sysroot/$SYSROOT_PKG
wget -c https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.bz2
clone https://github.com/GENIVI/capicxx-core-runtime
clone https://github.com/GENIVI/capicxx-someip-runtime
clone https://github.com/GENIVI/vsomeip
clone https://github.com/GENIVI/franca_ara_integration

mkdir -p $SYSROOT
echo "NOTE: Expecting that sysroot ($SYSROOT) was already populated"
if [ ! -d boost_1_67_0 ] ; then tar xf boost_1_67_0.tar.bz2 ; fi

# Set up SDK
. /xdt/sdk/environment-setup-corei7-64-agl-linux

./build-boost-proper.sh
./build-capicxx-core-runtime-proper.sh
./build-vsomeip-proper.sh
./build-capicxx-someip-runtime-proper.sh
./build-franca-ara-integration-proper.sh
./build-package-results.sh
