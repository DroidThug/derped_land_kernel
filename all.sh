echo -e "KERNEL"

KERNEL_DIR=$PWD
KERN_IMG=$KERNEL_DIR/arch/arm64/boot/Image
DTBTOOL=$KERNEL_DIR/dtbToolCM
BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'

# Modify the following variable if you want to build
export LD_LIBRARY_PATH="/home/aayushrd7/sb-4.9/lib"
export CROSS_COMPILE="/home/aayushrd7/sb-4.9/bin/aarch64-"
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="AayushRd7"
export KBUILD_BUILD_HOST="XeSki-PoWeR"
export LOCALVERSION="-XesKi™-v4"
STRIP="/home/aayushrd7/sb-4.9/bin/aarch64-strip"
MODULES_DIR=$KERNEL_DIR/drivers/staging/prima

compile_kernel ()
{
echo -e "****************************************************************************"
echo "                    "
echo "                                        Compiling Xeski Kernel             "
echo "                    "
echo -e "****************************************************************************"
make cyanogenmod_land_defconfig
make -j8
if ! [ -a $KERN_IMG ];
then
echo -e "$red Kernel Compilation failed! Fix the errors! $nocol"
exit 1
fi
$DTBTOOL -2 -o $KERNEL_DIR/arch/arm64/boot/dt.img -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/dts/
strip_modules
}

strip_modules ()
{
echo "Copying modules"
rm $MODULES_DIR/*
find . -name '*.ko' -exec cp {} $MODULES_DIR/ \;
cd $MODULES_DIR
echo "Stripping modules for size"
$STRIP --strip-unneeded *.ko
zip -9 modules *
cd $KERNEL_DIR
}

case $1 in
clean)
make ARCH=arm64 -j8 clean mrproper
rm -rf $KERNEL_DIR/arch/arm/boot/dt.img
;;
*)
compile_kernel
;;
esac

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
echo -e "********************************************************************"
echo "                    "
echo "                                        Enjoy XeskiKernel*.zip      "
echo "                            	           			  " 
echo " "
echo -e "********************************************************************"
