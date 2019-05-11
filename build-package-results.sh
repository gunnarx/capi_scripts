#!/bin/bash -xe

cd "$(dirname "$0")"
WORKDIR=$PWD
. ./config.sh

# Rough and dirty packaging of the libs...

D="$(readlink -f "$(dirname "$0")")"

sysroot="$SYSROOT"
[ -z "$SYSROOT" ] && sysroot=/home/user/sysroot_x86-64

cd "$sysroot"

pwd
tar --ignore-failed-read -cvzf $D/package.tar.gz \
    ./usr/lib/{libboost*,libCommonAPI*,libvsomeip*} \
    ./usr/lib/vsomeipd \
    ./usr/lib/capi_server

