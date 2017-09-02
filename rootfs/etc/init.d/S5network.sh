#!/bin/sh 

#configuration network device
 
echo "Config network..." 

echo "loop device" 
ifconfig lo 127.0.0.1 netmask 255.0.0.0 broadcast 127.255.255.255 up 
route add -net 127.0.0.0 netmask 255.0.0.0 lo  

echo "bridge br0" 
brctl addbr br0 
brctl stp br0 off 
brctl setfd br0 0 
#ifconfig br0 hw ether 00:11:33:22:44:54 
ifconfig br0 192.168.8.1 netmask 255.255.255.0 up 
