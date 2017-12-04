PKG_NAME		:= linux-3.10.49
PKG_SOURCE		:= $(PKG_NAME).tar.xz
PKG_SOURCE_URL		:= http://dl.zjuqsc.com/router/openwrt/dl/$(PKG_SOURCE)
PKG_UNTAR		:= tar -Jxvf

#export CC		= /opt/toolchains/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/bin/mips-openwrt-linux-gcc
#export CFLAGS		+= 
#export LDFLAGS		+= -L/opt/toolchains/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/lib
#export LIBS		+= -ldl
#export CROSS_COMPILE	= /opt/toolchains/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/bin/mips-openwrt-linux-
#export ARCH		= mips

CUR_DIR			:= $(shell pwd)
MAKE_DIR		= $(CUR_DIR)/$(PKG_NAME)/
PKG_CONFIG		= $(CUR_DIR)/dopatch.sh $(CUR_DIR)/patches $(MAKE_DIR)

export	Q		:= @

.PHONY: all install

check_untar_patch:
	mkdir -p $(CUR_DIR)/install

	$(Q)if [ ! -d $(CUR_DIR)/$(PKG_NAME) ]; then \
		if [ ! -f $(CUR_DIR)/$(PKG_SOURCE) ]; then \
			echo $(PKG_SOURCE) do not exist! Download from $(PKG_SOURCE_URL); \
			wget -P $(CUR_DIR) $(PKG_SOURCE_URL); \
		fi ;\
		$(PKG_UNTAR) $(PKG_SOURCE) 2> /dev/null ;\
		$(PKG_CONFIG);\
	fi

all: check_untar_patch
	cd $(MAKE_DIR); make 

clean:
	cd $(MAKE_DIR); make clean
	rm -rf $(CUR_DIR)/install

install:
	#vmlinux
	cp -rf $(MAKE_DIR)/vmlinux $(BUILD_DIR)	
	#usb
	cp -rf $(MAKE_DIR)/fs/nls/nls_base.ko $(ROOTFS_DIR)/lib/modules
	cp -rf $(MAKE_DIR)/drivers/usb/core/usbcore.ko $(ROOTFS_DIR)/lib/modules
	cp -rf $(MAKE_DIR)/drivers/usb/usb-common.ko $(ROOTFS_DIR)/lib/modules
	cp -rf $(MAKE_DIR)/drivers/usb/host/ehci-hcd.ko $(ROOTFS_DIR)/lib/modules
	cp -rf $(MAKE_DIR)/drivers/usb/host/ehci-platform.ko $(ROOTFS_DIR)/lib/modules
	#wireless
	cp -rf $(MAKE_DIR)/net/mac80211/mac80211.ko $(ROOTFS_DIR)/lib/modules
	cp -rf $(MAKE_DIR)/net/wireless/cfg80211.ko $(ROOTFS_DIR)/lib/modules
	cp -rf $(MAKE_DIR)/drivers/net/wireless/ath/ath.ko $(ROOTFS_DIR)/lib/modules
	cp -rf $(MAKE_DIR)/drivers/net/wireless/ath/ath9k/ath9k.ko $(ROOTFS_DIR)/lib/modules
	cp -rf $(MAKE_DIR)/drivers/net/wireless/ath/ath9k/ath9k_common.ko $(ROOTFS_DIR)/lib/modules
	cp -rf $(MAKE_DIR)/drivers/net/wireless/ath/ath9k/ath9k_hw.ko $(ROOTFS_DIR)/lib/modules
	
