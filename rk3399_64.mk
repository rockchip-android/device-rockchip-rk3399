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

$(call inherit-product, $(LOCAL_PATH)/rk3399.mk)

PRODUCT_NAME := rk3399_64
# debug-logs
ifneq ($(TARGET_BUILD_VARIANT),user)
MIXIN_DEBUG_LOGS ?= true
endif

BOARD_USE_APP_ALARM_ALIGNMENT ?= true

PRODUCT_COPY_FILES += \
   device/rockchip/rk3399/rk3399_64/ddr_config.xml:system/etc/ddr_config.xml \
   device/rockchip/rk3399/rk3399_64/video_status:system/etc/video_status
   
