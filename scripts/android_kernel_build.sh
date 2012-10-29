#!/bin/sh

ANDROID_ROOT="/home/justin/android/cm9"

KERNELS_ROOT="/home/justin/android/kernels"
TEMPLATES_ROOT="/home/justin/android/kernels/zip-templates"

export ARCH="arm"
export CROSS_COMPILE="$ANDROID_ROOT/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-"

KERNEL=$1
CONFIG=$2_deconfig

echo "*AKB*: Building $KERNEL using $CONFIG config"
#echo "*AKB*: Cleaning"
#make ARCH=arm clean
echo "*AKB*: Initializing kernel with $CONFIG_defconfig"
if [ -e $KERNEL_ROOT/arch/arm/configs/$_defconfig ]; then
    make ARCH= CROSS_COMPILE=$COMPILER_PREFIX $1_defconfig
    echo "*AKB*: Compiling kernel..."
    make ARCH=arm CROSS_COMPILE=$COMPILER_PREFIX
    if [ -e $KERNEL_ROOT/arch/arm/boot/zImage ]; then
        echo "*AKB*: Kernel was created successfully"
        echo "*AKB*: Moving kernel files to template"
        rm $TEMPLATE_ROOT/system/modules/*
        mv $KERNEL_ROOT/arch/arm/boot/zImage $TEMPLATE_ROOT/kernel/
        mv $KERNEL_ROOT/drivers/net/wireless/bcm4329/bcm4329.ko $TEMPLATE_ROOT/system/modules/
        echo "*AKB*: Stripping debug from modules"
        $COMPILER_ROOT/$COMPILER_PREFIXstrip --strip-debug $TEMPLATE_ROOT/system/modules/*
        echo "*AKB*: Kernel Ezmod Creation Successful"
    else
        echo "*AKB ERROR*: Kernel creation failed! ***"
    fi
    else
    echo "*AKB ERROR*: Kernel creation failed! ***"
fi
