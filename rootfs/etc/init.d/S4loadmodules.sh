#!/bin/sh 

#load modules
 
echo "Load modules..." 

echo "usb related" 
insmod /lib/modules/nls_base.ko
insmod /lib/modules/usb-common.ko
insmod /lib/modules/usbcore.ko
insmod /lib/modules/ehci-hcd.ko
insmod /lib/modules/ehci-platform.ko
