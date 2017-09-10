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
export BUILD_DIR	= $(TOP_DIR)/build
export STAGING_DIR      = $(BUILD_DIR)/staging
export ROOTFS_DIR       = $(TOP_DIR)/rootfs

export 	Q		:= @

KERNEL_DIR		= $(TOP_DIR)/kernel
USERSPACE_DIR		= $(TOP_DIR)/userspace 

IMAGE_NAME		= som9331-squashfs-sysupgrade.bin
HOST_TOOLS_DIR		= $(TOP_DIR)/hostTools/bin

.PHONY: kernel userspace

all: 

kernel:
	make -C $(KERNEL_DIR) all

kernel_install:
	make -C $(KERNEL_DIR) install

userspace:
	make -C $(USERSPACE_DIR) all

userspace_install:
	make -C $(USERSPACE_DIR) install

image: 
	find  $(ROOTFS_DIR)/lib/modules -name *.ko | xargs -n 1 $(OBJCOPY) --strip-debug
	find  $(ROOTFS_DIR)/lib/ -name *.so* | xargs -n 1 $(STRIP)

	rm -rf $(BUILD_DIR)/$(IMAGE_NAME)

	$(OBJCOPY) -O binary -R .reginfo -R .notes -R .note -R .comment -R .mdebug -R .note.gnu.build-id -S  $(BUILD_DIR)/vmlinux  $(BUILD_DIR)/vmlinux_strip

	cp $(BUILD_DIR)/vmlinux_strip $(BUILD_DIR)/som9331-kernel.bin

	#$(HOST_TOOLS_DIR)/patch-cmdline $(BUILD_DIR)/som9331-kernel.bin 'board=SOM9331  console=ttyATH0,115200'

	$(HOST_TOOLS_DIR)/mksquashfs  $(ROOTFS_DIR)  $(BUILD_DIR)/root.squashfs -nopad -noappend -root-owned -comp xz -Xpreset 9 -Xe -Xlc 0 -Xlp 2 -Xpb 2  -b 256k -p '/dev d 755 0 0' -p '/dev/console c 600 0 0 5 1' -processors 1 -fixed-time 1462363498

	$(HOST_TOOLS_DIR)/lzma e $(BUILD_DIR)/som9331-kernel.bin -lc1 -lp2 -pb2  $(BUILD_DIR)/som9331-kernel.bin.new 

	mv  $(BUILD_DIR)/som9331-kernel.bin.new $(BUILD_DIR)/som9331-kernel.bin

	dd if=$(BUILD_DIR)/root.squashfs  >> $(BUILD_DIR)/$(IMAGE_NAME)

	$(HOST_TOOLS_DIR)/mktplinkfw -H 0x07100001 -W 0x1 -F 8Mlzma -N OpenWrt -V r49295 -m 1 -k  $(BUILD_DIR)/som9331-kernel.bin -r  $(BUILD_DIR)/$(IMAGE_NAME) -o  $(BUILD_DIR)/$(IMAGE_NAME).new -j -X 0x40000 -a 0x4  -s 

	rm -rf $(BUILD_DIR)/$(IMAGE_NAME) && mv $(BUILD_DIR)/$(IMAGE_NAME).new $(BUILD_DIR)/$(IMAGE_NAME) 
	#rm -rf $(BUILD_DIR)/root.squashfs
	rm -rf $(BUILD_DIR)/som9331-kernel.bin	
