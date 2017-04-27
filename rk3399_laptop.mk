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

$(call inherit-product, $(LOCAL_PATH)/rk3399_64.mk)

PRODUCT_NAME := rk3399_laptop
PRODUCT_DEVICE := rk3399_laptop
PRODUCT_MODEL := rk3399-laptop

TARGET_BOARD_PLATFORM_PRODUCT := laptop

PRODUCT_AAPT_CONFIG := normal large hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := tvdpi

PRODUCT_SYSTEM_VERITY := true

# debug-logs
ifneq ($(TARGET_BUILD_VARIANT),user)
MIXIN_DEBUG_LOGS := true
endif

# google apps
BUILD_WITH_GOOGLE_MARKET := false
BUILD_WITH_GOOGLE_MARKET_ALL := false
BUILD_WITH_GOOGLE_FRP := false

#for data encrypt options
BUILD_WITH_FORCEENCRYPT := true

#for GMS Certification
BUILD_WITH_GMS_CER := false

#for drm widevine
BUILD_WITH_WIDEVINE := true

#for cts requirement
ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.adb.secure=1 \
    persist.sys.usb.config=mtp
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0 \
    persist.sys.usb.config=mtp,adb
endif

BOOT_SHUTDOWN_ANIMATION_RINGING := false

BOARD_NFC_SUPPORT := false
BOARD_HAS_GPS := false

BOARD_GRAVITY_SENSOR_SUPPORT := false
BOARD_COMPASS_SENSOR_SUPPORT := false
BOARD_GYROSCOPE_SENSOR_SUPPORT := false
BOARD_PROXIMITY_SENSOR_SUPPORT := false
BOARD_LIGHT_SENSOR_SUPPORT := false
BOARD_PRESSURE_SENSOR_SUPPORT := false
BOARD_TEMPERATURE_SENSOR_SUPPORT := false
BOARD_USB_HOST_SUPPORT := true
BOARD_LEDS_CONTROL := true
PRODUCT_HAS_CAMERA := true
TARGET_ROCKCHIP_PCBATEST := false

PRODUCT_COPY_FILES += \
   device/rockchip/rk3399/rk3399_64/ddr_config.xml:system/etc/ddr_config.xml \
   device/rockchip/rk3399/rk3399_64/video_status:system/etc/video_status 

PRODUCT_COPY_FILES += \
   device/rockchip/rk3399/Vendor_103c_Product_184f.kl:system/usr/keylayout/Vendor_103c_Product_184f.kl \
   device/rockchip/rk3399/Vendor_103c_Product_184f.idc:system/usr/idc/Vendor_103c_Product_184f.idc \
   device/rockchip/rk3399/rk29-keypad.idc:system/usr/idc/rk29-keypad.idc \

PRODUCT_PACKAGES += \
    SoundRecorder
