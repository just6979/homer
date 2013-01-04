#!/usr/bin/env bash

## CM setup & build shortcuts
export CM_VER=${CM_VER:='10.1'}
export CM_DEV='d2spr'
export CM_BASE='/home/justin/Android/CM'
export CM_ROOT=$CM_BASE$CM_VER
function cm_version {
    export CM_VER=$1
    export CM_ROOT=$CM_BASE$CM_VER
}
alias cm_find='if [ `pwd` != "$CM_ROOT" ]; then echo "Changing to $CM_ROOT"; cd $CM_ROOT; fi'
alias cm_envsetup='echo "Running envsetup."; source build/envsetup.sh'
alias cm_go='export OWD=`pwd`; cm_find; export CM_SHELL=1; screen -AOU -S CM; unset CM_SHELL; cd $OWD; unset OWD'
# repo maintainence
alias cm_sync='echo "Running \"repo sync\"."; repo sync'
alias cm_clean='echo "Cleaning build output."; make clobber'
# build it fresh
alias cm_cook='cm_clear_build_prop; cm_unofficial'
alias cm_science='cm_clear_build_prop; cm_experimental'
# build setup
alias cm_set_experimental='echo "Setting up for experimental build."; unset CM_UNOFFICIAL; export CM_EXTRAVERSION="crispy"; export CM_EXPERIMENTAL=1'
alias cm_set_unofficial='echo "Setting up for UNOFFICIAL build."; unset CM_EXTRAVERSION; unset CM_EXPERIMENTAL; export CM_UNOFFICIAL=1'
alias cm_clear_build_prop='echo "Clearing build.prop."; rm -f out/target/product/${CM_DEV}/system/build.prop'
# build it
alias cm_experimental='cm_envsetup; cm_set_experimental; echo "Building CM${CM_VER}-EXPERIMENTAL for ${CM_DEV}."; time brunch ${CM_DEV}'
alias cm_unofficial='cm_envsetup; cm_set_unofficial; echo "Building CM${CM_VER}-UNOFFICIAL for ${CM_DEV}."; time brunch ${CM_DEV}'

# ARM cross compiling toolchain setups
function cross-aosp-arm-linux-androideabi {
    export ARCH=arm
    export CROSS_COMPILE=arm-linux-androideabi-
    export PATH=~/Android/AOSP/prebuilt/linux-x86/toolchain/arm-linux-androideabi-4.4.x/bin/:$PATH
}

function cross-cm-arm-eabi {
    export ARCH=arm
    export CROSS_COMPILE=arm-eabi-
    export PATH=~/Android/CM/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin:$PATH
}

function cross-x-cm-arm-linux-androideabi {
    export ARCH=arm
    export CROSS_COMPILE=arm-eabi-
    export PATH=~/Android/CM/prebuilt/linux-x86/toolchain/arm-linux-androideabi-4.4.x/bin:$PATH
}

function cross-sourcery-arm-none-eabi {
    export ARCH=arm
    export CROSS_COMPILE=arm-none-eabi-
    export PATH=~/Apps/sourcery-2011.09/bin/:$PATH
}

function cross-x-sourcery-arm-none-linux-gnueabi {
    export ARCH=arm
    export CROSS_COMPILE=arm-none-linux-gnueabi-
    export PATH=~/Apps/sourcery-2011.09/bin/:$PATH
}

function fill-skeleton {
    ROOT='/home/justin/Android/kernels'
    KERNEL=$1
    SKELETON=$2
    K=$ROOT/$KERNEL
    S=$ROOT/$SKELETON
    cp -i $K/arch/arm/boot/zImage $S/kernel
    cp -i $K/drivers/net/wireless/bcm4329/bcm4329.ko $S/system/lib/modules
    cp -i $K/drivers/scsi/scsi_wait_scan.ko $S/system/lib/modules
}

if [ $CM_SHELL ]; then
    cm_find
    cm_envsetup
fi

