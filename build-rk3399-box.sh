#!/bin/bash

usage()
{
 echo "USAGE: [-o] [-u] [-v VERSION_NAME]"
 echo "No ARGS means use default build option"
 echo "WHERE: -o = generate ota package       "
 echo "       -u = generate update.img        "
 echo "       -v = set build version name for output image folder"
 exit 1
}

BUILD_UPDATE_IMG=false
BUILD_OTA=false
BUILD_VERSION="IMAGES"

# check pass argument
while getopts "ouv:" arg
do
  case $arg in
    o)
      echo "will build ota package"
      BUILD_OTA=true
      ;;
    u)
      echo "will build update.img"
      BUILD_UPDATE_IMG=true
      ;;
    v)
      BUILD_VERSION=$OPTARG
	  ;;
    ?)
      usage ;;
  esac
done

source build/envsetup.sh >/dev/null && setpaths
TARGET_PRODUCT=`get_build_var TARGET_PRODUCT`

#set jdk version
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
# source environment and chose target product
DEVICE=`get_build_var TARGET_PRODUCT`
BUILD_VARIANT=`get_build_var TARGET_BUILD_VARIANT`
UBOOT_DEFCONFIG=rk3399_box_defconfig
KERNEL_DEFCONFIG=rockchip_defconfig
KERNEL_DTS=rk3399-box-rev2
PACK_TOOL_DIR=RKTools/linux/Linux_Pack_Firmware
IMAGE_PATH=rockdev/Image-$TARGET_PRODUCT
export PROJECT_TOP=`gettop`

#lunch $DEVICE-$BUILD_VARIANT

PLATFORM_VERSION=`get_build_var PLATFORM_VERSION`
DATE=$(date  +%Y%m%d.%H%M)
STUB_PATH=Image/"$KERNEL_DTS"_"$PLATFORM_VERSION"_"$DATE"_"$BUILD_VERSION"
STUB_PATH="$(echo $STUB_PATH | tr '[:lower:]' '[:upper:]')"
export STUB_PATH=$PROJECT_TOP/$STUB_PATH
export STUB_PATCH_PATH=$STUB_PATH/PATCHES
#echo $STUB_PATH

# build uboot
echo "start build uboot"
cd u-boot && make distclean && make $UBOOT_DEFCONFIG && make ARCHV=aarch64 -j12 && cd -
if [ $? -eq 0 ]; then
    echo "Build uboot ok!"
else
    echo "Build uboot failed!"
    exit 1
fi


# build kernel
echo "Start build kernel"
cd kernel && make ARCH=arm64 $KERNEL_DEFCONFIG && make ARCH=arm64 $KERNEL_DTS.img -j12 && cd -
if [ $? -eq 0 ]; then
    echo "Build kernel ok!"
else
    echo "Build kernel failed!"
    exit 1
fi

lunch rk3399_box-userdebug

# build wifi driver ko
if [ -f "device/rockchip/common/build_wifi_ko.sh" ]; then
    echo "start build wifi driver ko"
    source device/rockchip/common/build_wifi_ko.sh
fi

# build android
echo "start build android"
make installclean
make -j12
if [ $? -eq 0 ]; then
    echo "Build android ok!"
else
    echo "Build android failed!"
    exit 1
fi

# mkimage.sh
echo "make and copy android images"
./mkimage.sh
if [ $? -eq 0 ]; then
    echo "Make image ok!"
else
    echo "Make image failed!"
    exit 1
fi

# copy images to rockdev
#echo "copy u-boot images"
#cp u-boot/uboot.img $IMAGE_PATH/
#cp u-boot/RK322XHMiniLoaderAll* $IMAGE_PATH/
#cp u-boot/trust.img $IMAGE_PATH/

#echo "copy kernel images"
#cp kernel/resource.img $IMAGE_PATH/
#cp kernel/kernel.img $IMAGE_PATH/

echo "copy manifest.xml"
cp manifest.xml $IMAGE_PATH/manifest_${DATE}.xml

if [ "$BUILD_OTA" = true ] ; then
  echo "generate ota package"
  make otapackage -j16
  ./mkimage.sh ota
  cp out/target/product/$TARGET_PRODUCT/${TARGET_PRODUCT}*.zip $IMAGE_PATH/
  cp out/target/product/$TARGET_PRODUCT/obj/PACKAGING/target_files_intermediates/${TARGET_PRODUCT}*.zip $IMAGE_PATH/
fi

if [ "$BUILD_UPDATE_IMG" = true ] ; then
  echo "generate update.img"
  cp -f $PACK_TOOL_DIR/rockdev_for_build/* rockdev/
  cd rockdev
  ./mkupdate.sh
  if [ $? -eq 0 ]; then
      echo "Make update image ok!"
  else
      echo "Make update image failed!"
      exit 1
  fi
  cd -
fi

mkdir -p $STUB_PATH

#Generate patches

.repo/repo/repo forall  -c '[ "$REPO_REMOTE" = "rk" -a "$REPO_RREV" != "refs/tags/android-6.0.1_r55" ] && { REMOTE_DIFF=`git log $REPO_REMOTE/$REPO_RREV..HEAD`; LOCAL_DIFF=`git diff`; [ -n "$REMOTE_DIFF" ] && { mkdir -p $STUB_PATCH_PATH/$REPO_PATH/; git format-patch $REPO_REMOTE/$REPO_RREV..HEAD -o $STUB_PATCH_PATH/$REPO_PATH; } || :; [ -n "$LOCAL_DIFF" ] && { mkdir -p $STUB_PATCH_PATH/$REPO_PATH/; git reset HEAD ./; git diff > $STUB_PATCH_PATH/$REPO_PATH/local_diff.patch; } || :; }'

#Copy stubs
cp manifest.xml $STUB_PATH/manifest_${DATE}.xml

mkdir -p $STUB_PATCH_PATH/kernel
cp kernel/.config $STUB_PATCH_PATH/kernel
cp kernel/vmlinux $STUB_PATCH_PATH/kernel

mkdir -p $STUB_PATH/IMAGES/
cp $IMAGE_PATH/* $STUB_PATH/IMAGES/

#Save build command info
echo "UBOOT:  defconfig: $UBOOT_DEFCONFIG" >> $STUB_PATH/build_cmd_info
echo "KERNEL: defconfig: $KERNEL_DEFCONFIG, dts: $KERNEL_DTS" >> $STUB_PATH/build_cmd_info
echo "ANDROID:$DEVICE-$BUILD_VARIANT" >> $STUB_PATH/build_cmd_info
