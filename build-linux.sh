# LINUX
CURDIR=`pwd`
LINUXDIR=$CURDIR/linux
cd $LINUXDIR

export PATH=$PATH:$CURDIR/toolchain/gcc-linaro-aarch64-none-elf-4.9-2014.07_linux/bin
export CROSS_COMPILE=$CURDIR/toolchain/gcc-linaro-aarch64-none-elf-4.9-2014.07_linux/bin/aarch64-none-elf-

# A POSIX variable
OPTIND=1 # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
ARCH=arm64

show_help() {
	echo "  -h help"
	echo "  -c cleans linux build (mrproper)"
	echo "  -f set CONFIG_INITRAMFS_SOURCE to filesystem.cpio.gz"
	echo "  -m menuconfig"
}

while getopts "h?cfm" opt; do
	case "$opt" in
		h|\?)
			show_help
			exit 0
			;;

		c)  	make mrproper
			make ARCH=$ARCH defconfig
			exit 0
			;;

		f) 	$LINUXDIR/scripts/config --file $LINUXDIR/.config --set-str INITRAMFS_SOURCE "$CURDIR/Foundation_Platformpkg/filesystem.cpio.gz"
			exit 0
			;;

		m)  	make ARCH=$ARCH menuconfig
			exit 0
			;;
	esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

make -j`nproc` ARCH=$ARCH
