# Source this file...

APERTIS_RELEASE=v2019dev0/v2019dev0.0

# RENESAS
#SYSROOT=/xdt/sdk/sysroots/aarch-FIXME
#SYSROOT_PKG=ospack_v2019dev0-arm64-sysroot_v2019dev0.0.tar.gz
#ARCH=arm64
#GCC_ARCH=aarch64-linux-gnu

## MINNOWBOARD / X86
SYSROOT=/xdt/sdk/sysroots/corei7-64-agl-linux
SYSROOT_PKG=
ARCH=amd64
GCC_ARCH=x86_64-linux-gnu

# Set up SDK, done for each of the build scripts
. /xdt/sdk/environment-setup-corei7-64-agl-linux
