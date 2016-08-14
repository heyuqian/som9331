BUILD_SET = mksquashfs lzma mktplinkfw patch-cmdline
#DL = /home/vagrant/dl

.PHONY: $(BUILD_SET)
all: $(BUILD_SET)

mksquashfs:
	@echo building mksquashfs host tool ...
	#tar -zxvf $(DL)/squashfs4.2.tar.gz -C ./ 2> /dev/null 
	make -C squashfs4.2/squashfs-tools/ 
	cp squashfs4.2/squashfs-tools/mksquashfs ./bin/

mksquashfs_clean:
	@echo clean mksquashfs host tool ...
	make -C squashfs4.2/squashfs-tools/ clean

lzma:
	@echo building lzma host tool ...
	#tar -jxvf $(DL)/lzma-4.32.tar.bz2 -C ./ 2> /dev/null
	make -C lzma-4.32/C/7zip/Compress/LZMA_Alone/ -f makefile.gcc
	cp lzma-4.32/C/7zip/Compress/LZMA_Alone/lzma ./bin/

lzma_clean:
	@echo clean lzma host tool ...
	make -C lzma-4.32/C/7zip/Compress/LZMA_Alone/ -f makefile.gcc clean

mktplinkfw:
	@echo building mktplinkfw host tool ...
	make -C mktplinkfw/
	cp mktplinkfw/mktplinkfw ./bin/

mktplinkfw_clean:
	@echo clean mktplinkfw host tool ...
	make -C mktplinkfw/ clean

patch-cmdline:
	@echo building patch-cmdline host tool ...
	make -C patch-cmdline/
	cp patch-cmdline/patch-cmdline ./bin/

patch-cmdline_clean:
	@echo clean patch-cmdline host tool ...
	make -C patch-cmdline/ clean

clean: mksquashfs_clean lzma_clean mktplinkfw_clean patch-cmdline_clean
