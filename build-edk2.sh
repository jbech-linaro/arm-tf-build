# EDK2
CURDIR=`pwd`
cd $CURDIR/edk2

export PATH=$PATH:$CURDIR/toolchain/gcc-linaro-aarch64-none-elf-4.9-2014.07_linux/bin
export CROSS_COMPILE=$CURDIR/toolchain/gcc-linaro-aarch64-none-elf-4.9-2014.07_linux/bin/aarch64-none-elf-

source edksetup.sh

# A POSIX variable
OPTIND=1 # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
EDK2_BUILD=RELEASE

show_help() {
	echo "  -h help"
	echo "  -c cleans and builds BaseTools"
	echo "  -d debug build for EDK2"
}

while getopts "h?cd" opt; do
	case "$opt" in
		h|\?)
			show_help
			exit 0
			;;

		c)  	make -C BaseTools clean
			make -C BaseTools
			exit 0
			;;

		d)	unset EDK2_BUILD
			;;
	esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

GCC49_AARCH64_PREFIX=$CROSS_COMPILE \
	make -f ArmPlatformPkg/Scripts/Makefile EDK2_ARCH=AARCH64 \
	EDK2_DSC=ArmPlatformPkg/ArmVExpressPkg/ArmVExpress-FVP-AArch64.dsc \
	EDK2_TOOLCHAIN=GCC49 EDK2_BUILD=$EDK2_BUILD \
	EDK2_MACROS="-n 6 -D ARM_FOUNDATION_FVP=1"
