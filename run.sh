#!/bin/sh
# RUN
CURDIR=`pwd`
cd $CURDIR/Foundation_Platformpkg

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
DEBUG=0

BL1=$CURDIR/arm-trusted-firmware/build/fvp/release/bl1.bin
FIP=$CURDIR/arm-trusted-firmware/build/fvp/release/fip.bin

show_help() {
	echo "  -h help"
	echo "  -d run DEBUG configuration"
	echo "  -i (force) installs symlinks to Image and fdt.dtb"
}

while getopts "h?cdi" opt; do
	case "$opt" in
		h|\?)
			show_help
			exit 0
			;;

		d)  	DEBUG=1
			BL1=$CURDIR/arm-trusted-firmware/build/fvp/debug/bl1.bin
			FIP=$CURDIR/arm-trusted-firmware/build/fvp/debug/fip.bin
			;;

		i)	ln -sf $CURDIR/linux/arch/arm64/boot/Image
			ln -sf $CURDIR/arm-trusted-firmware/fdts/fvp-foundation-gicv2-psci.dtb fdt.dtb
			exit 0
	esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

$CURDIR/Foundation_Platformpkg/models/Linux64_GCC-4.1/Foundation_Platform \
        --cores=4 \
        --secure-memory \
        --visualization \
        --gicv3 \
        --data="${BL1}"@0x0 \
        --data="${FIP}"@0x8000000
