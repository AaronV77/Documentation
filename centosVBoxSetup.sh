#!/bin/sh

read -p "Please be root already when running this script. (Just hit enter): " $random
read -p "Please Insert Guest Additions, under the Devices. (Just hit enter): " $random2

cd ~
sudo yum update
sudo yum update kernel*
mkdir /media/VirtualBoxGuestAdditions
mount -r /dev/cdrom /media/VirtualBoxGuestAdditions
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install gcc kernel-devel kernel-headers dkms make bzip2 perl
KERN_DIR=/usr/src/kernels/`uname -r`
export KERN_DIR
cd /media/VirtualBoxGuestAdditions
./VBoxLinuxAdditions.run
reboot
