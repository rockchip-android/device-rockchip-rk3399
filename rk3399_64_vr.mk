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

PRODUCT_NAME := rk3399_64_vr
PRODUCT_DEVICE := rk3399_64_vr
PRODUCT_MODEL := rk3399-vr
# debug-logs
ifneq ($(TARGET_BUILD_VARIANT),user)
MIXIN_DEBUG_LOGS ?= true
endif

DOUBLE_SCREEN ?= YES
ROTATE_SCREEN ?= rotate_90
DUAL_SCREEN ?= false

BOOT_SHUTDOWN_ANIMATION_RINGING ?= true
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rk3399_64_vr/rk-ovr.ko:/system/lib/modules/rk_ovr.ko

ifeq ($(DUAL_SCREEN),true)
PRODUCT_PROPERTY_OVERRIDES := \
	ro.sf.hwrotation=180 \
	sys.xxx.x_w=0 \
	sys.xxx.x_h=0 \
	sys.vr.panel=1 \
	sys.vr.params.inter=0.055 \
	sys.vr.params.vert=0.037 \
	sys.vr.params.screen=0.031 \
	sys.vr.params.bk1=0.19 \
	sys.vr.params.bk2=0.20 \
	vr.video.direct=true
else
	PRODUCT_PROPERTY_OVERRIDES := \
	ro.sf.hwrotation=0 \
	sys.xxx.x_w=1152 \
	sys.xxx.x_h=2048 \
	persist.display.portrait=true
endif
