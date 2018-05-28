PKG_NAME		:= lrzsz-0.12.20
PKG_SOURCE		:= $(PKG_NAME).tar.gz
PKG_SOURCE_URL		:= https://ohse.de/uwe/releases/$(PKG_SOURCE)
PKG_UNTAR		:= tar -zxvf

CUR_DIR			:= $(shell pwd)
MAKE_DIR		= $(CUR_DIR)/$(PKG_NAME)/
PKG_CONFIG		= cd $(MAKE_DIR); ./configure --host=mips-openwrt-linux  --prefix=$(CUR_DIR)/install 

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
	cd $(MAKE_DIR); make; make install

clean:
	if [ -d $(MAKE_DIR) ]; then \
		cd $(MAKE_DIR); make clean; \
		rm -rf $(CUR_DIR)/install; \
	fi ;

install:
	$(OBJCOPY) $(CUR_DIR)/install/bin/lsz --strip-debug
	$(OBJCOPY) $(CUR_DIR)/install/bin/lrz --strip-debug
	cp -rf $(CUR_DIR)/install/bin/lsz $(ROOTFS_DIR)/sbin/
	cp -rf $(CUR_DIR)/install/bin/lrz $(ROOTFS_DIR)/sbin/
	cp -rf $(CUR_DIR)/install/share $(ROOTFS_DIR)/
