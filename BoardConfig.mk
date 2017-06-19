#
# Copyright 2014 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Use the non-open-source parts, if they're present
-include vendor/rockchip/rk3399/BoardConfigVendor.mk
-include device/rockchip/common/BoardConfig.mk

TARGET_PREBUILT_KERNEL := kernel/arch/arm64/boot/Image

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_SMP := true

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53.a57


# Disable emulator for "make dist" until there is a 64-bit qemu kernel
BUILD_EMULATOR := false

TARGET_BOARD_PLATFORM := rk3399
TARGET_BOARD_PLATFORM_GPU := mali-t860
BOARD_USE_DRM := true

# RenderScript
# OVERRIDE_RS_DRIVER := libnvRSDriver.so
BOARD_OVERRIDE_RS_CPU_VARIANT_32 := cortex-a53
BOARD_OVERRIDE_RS_CPU_VARIANT_64 := cortex-a53
# DISABLE_RS_64_BIT_DRIVER := true

TARGET_USES_64_BIT_BCMDHD := true
TARGET_USES_64_BIT_BINDER := true
# BOARD_USE_AFBC_LAYER := true

# HACK: Build apps as 64b for volantis_64_only
ifneq (,$(filter ro.zygote=zygote64, $(PRODUCT_DEFAULT_PROPERTY_OVERRIDES)))
TARGET_PREFER_32_BIT_APPS :=
TARGET_SUPPORTS_64_BIT_APPS := true
endif

# Sensors
BOARD_SENSOR_ST := false
BOARD_SENSOR_MPU := false
BOARD_SENSOR_MPU_VR := true
#BOARD_USES_GENERIC_INVENSENSE := false

# GPU MaliT860 support opengl aep
BOARD_OPENGL_AEP := true

# Copy rk3399 own init.rc file
# TARGET_PROVIDES_INIT_RC := true


//MAX-SIZE=2G, for generate out/.../system.img
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612736

ENABLE_CPUSETS := true
#for optee support
PRODUCT_HAVE_OPTEE ?= false

BOARD_USE_SPARSE_SYSTEM_IMAGE := true
