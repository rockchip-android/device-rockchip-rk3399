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

PRODUCT_NAME := rk3399_disvr
PRODUCT_DEVICE := rk3399_disvr
PRODUCT_MODEL := rk3399_disvr

# debug-logs
ifneq ($(TARGET_BUILD_VARIANT),user)
MIXIN_DEBUG_LOGS ?= true
endif

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/rk3399_64_vr/rk-ovr.ko:/system/lib/modules/rk_ovr.ko \
	$(LOCAL_PATH)/rk3399_disvr/rkvrd:/system/bin/rkvrd
