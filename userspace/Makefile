all:
	make -C libs/libnl/ all
	make -C libs/openssl/ all
	make -C apps/hostapd/ all
	make -C apps/busybox/ all
	make -C apps/openvswitch/ all

install:
	make -C apps/busybox/ install
	make -C apps/hostapd/ install
	make -C apps/openvswitch/ install
	#make -C libs/openssl/ install
	make -C libs/libnl/ install
