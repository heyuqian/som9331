BUILD_SET = mksquashfs
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

clean: mksquashfs_clean
	
