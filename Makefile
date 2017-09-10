export TOOLCHAIN_DIR	= /opt/toolchains/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/
export CROSS_COMPILE	= $(TOOLCHAIN_DIR)/bin/mips-openwrt-linux-
export ARCH		= mips

export AR		= $(CROSS_COMPILE)ar
export AS		= $(CROSS_COMPILE)as
export LD		= $(CROSS_COMPILE)ld
export NM		= $(CROSS_COMPILE)nm
export CC		= $(CROSS_COMPILE)gcc
export GCC		= $(CROSS_COMPILE)gcc
export CXX		= $(CROSS_COMPILE)g++
export CPP		= $(CROSS_COMPILE)cpp
export RANLIB		= $(CROSS_COMPILE)ranlib
export STRIP		= $(CROSS_COMPILE)strip
export SSTRIP		= $(CROSS_COMPILE)sstrip
export OBJCOPY		= $(CROSS_COMPILE)objcopy
export OBJDUMP		= $(CROSS_COMPILE)objdump
export GDB		= $(CROSS_COMPILE)gdb

TOP_DIR			= $(shell pwd)
BUILD_DIR		= $(TOP_DIR)/build
export STAGING_DIR      = $(BUILD_DIR)/staging

export 	Q		:= @

KERNEL_DIR		:= $(TOP_DIR)/kernel
USERSPACE_DIR		:= $(TOP_DIR)/userspace 

.PHONY: kernel userspace

all: kernel userspace
	$(Q)if [ ! -d $(BUILD_DIR) ]; then \
		mkdir -p $(BUILD_DIR); \
		mkdir -p $(STAGING_DIR);\
	fi

clean:
	$(Q)rm -rf $(BUILD_DIR);

kernel:
	make -C $(KERNEL_DIR) all

userspace:
	make -C $(USERSPACE_DIR) all
