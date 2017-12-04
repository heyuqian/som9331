#!/bin/sh 

#load modules
 
echo "Load modules..." 

echo "usb related" 
insmod /lib/modules/nls_base.ko
insmod /lib/modules/usb-common.ko
insmod /lib/modules/usbcore.ko
insmod /lib/modules/ehci-hcd.ko
insmod /lib/modules/ehci-platform.ko

echo "wlan related"
insmod /lib/modules/cfg80211.ko
insmod /lib/modules/mac80211.ko
insmod /lib/modules/ath.ko
insmod /lib/modules/ath9k_hw.ko
insmod /lib/modules/ath9k_common.ko
insmod /lib/modules/ath9k.ko
