echo -e "KERNEL"
KERNEL_DIR=~/R3s/kernel
DTBTOOL=$KERNEL_DIR/dtbToolCM
KERN_IMG=$KERNEL_DIR/arch/arm64/boot/Image
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
make cyanogenmod_land_defconfig
make -j8
