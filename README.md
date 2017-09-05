# som9331

Introduce:

som9331 is an embedded device

have one wan port, two lan ports, and one usb 2.0

support wifi 11b/g/n 1x1 

(more information in dir /docs)

this project is to porting linux system to support som9331

include  kernel、busybox、rootfs and so on

HOW-TO:

my system is centos-7.0 x86_64

1、install toolchain

pls download toolchain:

http://downloads.openwrt.org/barrier_breaker/14.07/ar71xx/generic/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2

and install:

sudo tar -jxvf /vagrant/share/som9331/OpenWrt-Toolchain-ar71xx-for-mips_34kc-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2 -C /opt/toolchains/

2、get the source code

git clone this project in your local system

3、build this project

pls read the Makefile in the root directory

make kernel

make busybox

make image

4、upload the image

build/som9331-squashfs-sysupgrade.bin

Ps: if have any problem with this project, feel free to contact with me: heyuqian2013@163.com

    i have write some articles to summarize this project, you can find them: http://blog.csdn.net/heyuqian_csdn
