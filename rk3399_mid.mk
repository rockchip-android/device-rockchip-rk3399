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

PRODUCT_NAME := rk3399_mid
PRODUCT_DEVICE := rk3399_mid
PRODUCT_MODEL := rk3399-mid

PRODUCT_AAPT_CONFIG := normal large mdpi tvdpi hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# debug-logs
ifneq ($(TARGET_BUILD_VARIANT),user)
MIXIN_DEBUG_LOGS := true
endif

# google apps
BUILD_WITH_GOOGLE_MARKET := true
BUILD_WITH_GOOGLE_MARKET_ALL := true
BUILD_WITH_GOOGLE_FRP := true

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
