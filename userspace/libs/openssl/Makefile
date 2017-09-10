PKG_NAME		:= openssl-1.0.2l
PKG_SOURCE		:= $(PKG_NAME).tar.gz
PKG_SOURCE_URL		:= https://www.openssl.org/source/$(PKG_SOURCE)
PKG_UNTAR		:= tar -zxvf

#export CC		= gcc
export CFLAGS		+= 
export LDFLAGS		+= -L$(TOOLCHAIN_DIR)/lib
export LIBS		+=

CUR_DIR			:= $(shell pwd)
MAKE_DIR                = $(CUR_DIR)/$(PKG_NAME)/
PKG_CONFIG		= cp $(CUR_DIR)/Configure $(MAKE_DIR); cd $(MAKE_DIR); ./Configure os:$(CC) --prefix=$(CUR_DIR)/install


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
		$(PKG_CONFIG);\
	fi

all: check_untar_patch
	cd $(PKG_NAME); make; make install

clean:
	cd $(PKG_NAME); make clean
	rm -rf $(CUR_DIR)/install
