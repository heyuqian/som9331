PKG_NAME		:= openssl-1.0.2l
PKG_SOURCE		:= $(PKG_NAME).tar.gz
PKG_SOURCE_URL		:= https://www.openssl.org/source/$(PKG_SOURCE)
PKG_UNTAR		:= tar -zxvf

export CC		= /opt/toolchains/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/bin/mips-openwrt-linux-gcc
export CFLAGS		+= 
export LDFLAGS		+= -L/opt/toolchains/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2/toolchain-mips_34kc_gcc-4.8-linaro_uClibc-0.9.33.2/lib
export LIBS		+=

CUR_DIR			:= $(shell pwd)
PKG_CONFIG		= ./Configure os:$(CC) --prefix=$(CUR_DIR)/install


export 	Q		:= @

.PHONY: all

check_untar_patch:
	mkdir -p $(CUR_DIR)/install

	$(Q)if [ ! -d $(CUR_DIR)/$(PKG_NAME) ]; then \
		if [ ! -f $(CUR_DIR)/$(PKG_SOURCE) ]; then \
			echo $(PKG_SOURCE) do not exist! Download from $(PKG_SOURCE_URL); \
			wget -P $(CUR_DIR) $(PKG_SOURCE_URL); \
		fi ;\
		$(PKG_UNTAR) $(PKG_SOURCE) 2> /dev/null ;\
	fi

all: check_untar_patch
	cd $(PKG_NAME); $(PKG_CONFIG); make; make install

clean:
	cd $(PKG_NAME); make clean
	rm -rf $(CUR_DIR)/install
