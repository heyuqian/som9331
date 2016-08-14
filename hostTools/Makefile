BUILD_SET = mksquashfs lzma
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

clean: mksquashfs_clean lzma_clean
	
