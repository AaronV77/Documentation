#!/bin/sh

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1

else 

read -p "Is this an ost server? (y/n): " ost

	if [ ("$ost" == "y") -o ("$ost" == "Y") ]
	then

		read -p "MGS node IP address: " address
		ifup enp0s8
		modprobe lnet
		lctl network up
		lctl list_nids
		mkfs.lustre --ost --fsname=temp --mgsnode=$address@tcp0 --index=0 /dev/sdb
		mkdir /mnt/ost
		mount -t lustre /dev/sdb /mnt/ost
		mount
		reset
		df -h
		mv lustre-server-P2.sh /root

	elif [ ("$ost" == "n") -o ("$ost" == "N") ]
	then 
	
		ifup enp0s8
		modprobe lnet
		lctl network up
		lctl list_nids
		mkfs.lustre --fsname=temp --mgs --mdt --index=0 /dev/sdb
		mkdir /mnt/mdt
		mount -t lustre /dev/sdb /mnt/ost
		mount
		reset
		df -h
		mv lustre-server-P2.sh /root

	else 

	echo " Sorry didn't understand the input." 

	fi

fi
