include device/rockchip/rk3399/BoardConfig.mk

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
TARGET_2ND_CPU_VARIANT := cortex-a15

# Re-enable emulator for 32-bit
BUILD_EMULATOR := false

TARGET_BOARD_PLATFORM_PRODUCT := box

# Set system.img size
ifeq ($(strip $(BUILD_BOX_WITH_GOOGLE_MARKET)), true)
  BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1500000000
else
  ifeq ($(TARGET_BUILD_VARIANT),user)
    BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1500000000
  else
    BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1200000000
  endif
endif

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),user)
    WITH_DEXPREOPT := true
  else
    WITH_DEXPREOPT := false
  endif
endif
