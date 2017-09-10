#!/bin/sh

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1

else 

read -p "MGS node IP address: " address
ifup enp0s8
modprobe lustre
mkdir /mnt/lustre
mount -t lustre $address@tcp0:/temp /mnt/lustre
mount 
reset
df -h
mv lustre-client-P2.sh /root

fi
