PKG_NAME		:= openvswitch-2.5.3
PKG_SOURCE		:= $(PKG_NAME).tar.gz
PKG_SOURCE_URL		:= http://openvswitch.org/releases/$(PKG_SOURCE)
PKG_UNTAR		:= tar -zxvf

export TOOLCHAIN_DIR	= /opt/toolchains/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/
export CROSS_COMPILE	= $(TOOLCHAIN_DIR)/bin/mips-openwrt-linux-
export CC		= /opt/toolchains/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/bin/mips-openwrt-linux-gcc
export CFLAGS		+= -g -O2
export LDFLAGS		+= -L/opt/toolchains/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/lib
export LIBS		+= 

CUR_DIR			:= $(shell pwd)
MAKE_DIR		= $(CUR_DIR)/$(PKG_NAME)/
PKG_CONFIG		= cd $(MAKE_DIR); ./configure --prefix=$(CUR_DIR)/install --with-linux=/home/vagrant/som9331/kernel/linux-3.10.49 KARCH=mips --enable-Werror --host=mips-openwrt-linux 

export 	Q		:= @

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
	cd $(MAKE_DIR); make; make install;

clean:
	cd $(MAKE_DIR); make clean
	rm -rf $(CUR_DIR)/install

install:
	cp $(MAKE_DIR)/datapath/linux/openvswitch.ko $(ROOTFS_DIR)/lib/modules/ 	

	$(OBJCOPY) $(CUR_DIR)/install/bin/ovs-appctl --strip-debug
	$(OBJCOPY) $(CUR_DIR)/install/bin/ovs-ofctl --strip-debug
	$(OBJCOPY) $(CUR_DIR)/install/bin/ovs-vsctl --strip-debug
	cp -rf $(CUR_DIR)/install/bin/ovs-appctl $(ROOTFS_DIR)/bin/
	cp -rf $(CUR_DIR)/install/bin/ovs-ofctl $(ROOTFS_DIR)/bin/
	cp -rf $(CUR_DIR)/install/bin/ovs-vsctl $(ROOTFS_DIR)/bin/

