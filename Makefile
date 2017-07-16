export CROSS_COMPILE=/opt/toolchains/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/bin/mips-openwrt-linux-
export ARCH=mips

CFLAGS			+=
LDFLAGS			+=

export AR=$(CROSS_COMPILE)ar
export AS=$(CROSS_COMPILE)as
export LD=$(CROSS_COMPILE)ld
export NM=$(CROSS_COMPILE)nm
export CC=$(CROSS_COMPILE)gcc
export GCC=$(CROSS_COMPILE)gcc
export CXX=$(CROSS_COMPILE)g++
export CPP=$(CROSS_COMPILE)cpp
export RANLIB=$(CROSS_COMPILE)ranlib
export STRIP=$(CROSS_COMPILE)strip
export SSTRIP=$(CROSS_COMPILE)sstrip
export OBJCOPY=$(CROSS_COMPILE)objcopy
export OBJDUMP=$(CROSS_COMPILE)objdump
export GDB=$(CROSS_COMPILE)gdb

KERNEL_VER              := linux-3.10.49
TOP_DIR			:= $(shell pwd)
KERNEL_DIR		:= $(TOP_DIR)/kernel
BUILD_DIR		:= $(TOP_DIR)/build
DL_DIR		        := $(TOP_DIR)/dl
HOST_TOOLS_DIR		:= $(TOP_DIR)/hostTools/bin
ROOTFS_DIR		:= $(TOP_DIR)/rootfs

IMAGE_NAME		:= som9331-squashfs-sysupgrade.bin

export STAGING_DIR=$(BUILD_DIR)/staging

.PHONY: kernel image

kernel:
	if [ ! -d $(KERNEL_DIR)/$(KERNEL_VER) ];then \
		echo $(KERNEL_DIR) do not exist! ;\
		if [ ! -f $(DL_DIR)/$(KERNEL_VER).tar.xz ]; then \
			wget -P $(DL_DIR) http://dl.zjuqsc.com/router/openwrt/dl/$(KERNEL_VER).tar.xz; \
		fi \
	fi

	if [ ! -d $(KERNEL_DIR)/$(KERNEL_VER) ];then \
		tar -Jxvf $(DL_DIR)/$(KERNEL_VER).tar.xz -C $(KERNEL_DIR) ;\
		ln -s $(KERNEL_DIR)/$(KERNEL_VER) $(KERNEL_DIR)/linux ;\
	fi

	mkdir -p $(STAGING_DIR)
	#mkdir -p $(KERNEL_DIR)/linux/arch/mips/include/asm/mach-ath79

	cp patches/mach-som9331.c kernel/linux/arch/mips/ath79/
	cp patches/dev-m25p80.h kernel/linux/arch/mips/ath79/
	cp patches/dev-m25p80.c kernel/linux/arch/mips/ath79/
	cp patches/dev-eth.h kernel/linux/arch/mips/ath79/
	cp patches/dev-eth.c kernel/linux/arch/mips/ath79/
	cp patches/ath79_Kconfig  kernel/linux/arch/mips/ath79/Kconfig
	cp patches/ath79_Makefile kernel/linux/arch/mips/ath79/Makefile
	cp patches/som9331_config kernel/linux/.config

	cp patches/ag71xx_platform.h kernel/linux/arch/mips/include/asm/mach-ath79/
	cp patches/ar71xx_regs.h kernel/linux/arch/mips/include/asm/mach-ath79/

	cp patches/flash.h kernel/linux/include/linux/spi/flash.h
	cp patches/ath79_machtypes.h kernel/linux/arch/mips/ath79/machtypes.h
	cp patches/ath79_spi_platform.h kernel/linux/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h 
	cp patches/spi-ath79.c kernel/linux/drivers/spi/spi-ath79.c
	cp patches/spi.h kernel/linux/include/linux/spi/spi.h
	cp patches/spi-bitbang.c kernel/linux/drivers/spi/
	cp patches/spi_bitbang.h kernel/linux/include/linux/spi/spi_bitbang.h

	#mtd
	cp patches/tplinkpart.c kernel/linux/drivers/mtd/
	cp patches/mtd_Makefile kernel/linux/drivers/mtd/Makefile
	cp patches/mtd_Kconfig kernel/linux/drivers/mtd/Kconfig
	cp patches/mtdsplit* kernel/linux/drivers/mtd/
	cp patches/mtd.h kernel/linux/include/linux/mtd/mtd.h
	cp patches/mtdpart.c kernel/linux/drivers/mtd/mtdpart.c
	cp patches/partitions.h kernel/linux/include/linux/mtd/partitions.h

	make -C $(KERNEL_DIR)/linux

tools:
	make -C $(HOST_TOOLS_DIR)/../ all


image:
	rm -rf $(BUILD_DIR)/$(IMAGE_NAME)
	cp -rf $(KERNEL_DIR)/linux/vmlinux $(BUILD_DIR)/vmlinux 

	$(OBJCOPY) -O binary -R .reginfo -R .notes -R .note -R .comment -R .mdebug -R .note.gnu.build-id -S  $(BUILD_DIR)/vmlinux  $(BUILD_DIR)/vmlinux

	mv $(BUILD_DIR)/vmlinux $(BUILD_DIR)/som9331-kernel.bin

	#$(HOST_TOOLS_DIR)/patch-cmdline $(BUILD_DIR)/som9331-kernel.bin 'board=SOM9331  console=ttyATH0,115200'

	$(HOST_TOOLS_DIR)/mksquashfs  $(ROOTFS_DIR)  $(BUILD_DIR)/root.squashfs -nopad -noappend -root-owned -comp xz -Xpreset 9 -Xe -Xlc 0 -Xlp 2 -Xpb 2  -b 256k -p '/dev d 755 0 0' -p '/dev/console c 600 0 0 5 1' -processors 1 -fixed-time 1462363498

	$(HOST_TOOLS_DIR)/lzma e $(BUILD_DIR)/som9331-kernel.bin -lc1 -lp2 -pb2  $(BUILD_DIR)/som9331-kernel.bin.new 

	mv  $(BUILD_DIR)/som9331-kernel.bin.new $(BUILD_DIR)/som9331-kernel.bin

	dd if=$(BUILD_DIR)/root.squashfs  >> $(BUILD_DIR)/$(IMAGE_NAME)

	$(HOST_TOOLS_DIR)/mktplinkfw -H 0x07100001 -W 0x1 -F 8Mlzma -N OpenWrt -V r49295 -m 1 -k  $(BUILD_DIR)/som9331-kernel.bin -r  $(BUILD_DIR)/$(IMAGE_NAME) -o  $(BUILD_DIR)/$(IMAGE_NAME).new -j -X 0x40000 -a 0x4  -s 

	rm -rf $(BUILD_DIR)/$(IMAGE_NAME) && mv $(BUILD_DIR)/$(IMAGE_NAME).new $(BUILD_DIR)/$(IMAGE_NAME) 
	rm -rf $(BUILD_DIR)/root.squashfs
	rm -rf $(BUILD_DIR)/som9331-kernel.bin
