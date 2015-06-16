#!/bin/sh
# ARM-TF
CURDIR=`pwd`
EDK2BIN=$CURDIR/edk2/Build/ArmVExpress-FVP-AArch64/RELEASE_GCC49/FV/FVP_AARCH64_EFI.fd

cd $CURDIR/arm-trusted-firmware

export PATH=$PATH:$CURDIR/toolchain/gcc-linaro-aarch64-none-elf-4.9-2014.07_linux/bin
export CROSS_COMPILE=$CURDIR/toolchain/gcc-linaro-aarch64-none-elf-4.9-2014.07_linux/bin/aarch64-none-elf-

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
DEBUG=0

show_help() {
	echo "  -h help"
	echo "  -c cleans arm-trusted-firmware"
	echo "  -d debug build"
}

while getopts "h?cd" opt; do
	case "$opt" in
		h|\?)
			show_help
			exit 0
			;;
		c)  	make realclean
			exit 0
			;;
		d) 	DEBUG=1
			;;
	esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

CROSS_COMPILE=$CURDIR/toolchain/gcc-linaro-aarch64-none-elf-4.9-2014.07_linux/bin/aarch64-none-elf- \
	BL33=$EDK2BIN \
	make -j`nproc` PLAT=fvp DEBUG=$DEBUG all fip
