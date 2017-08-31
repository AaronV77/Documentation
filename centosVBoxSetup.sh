#!/bin/sh

read -p "Please Insert Guest Additions, under the Devices. (Just hit enter): " $random

cd ~
sudo passwd
su
yum update
yum update kernel*
mkdir /media/VirtualBoxGuestAdditions
mount -r /dev/cdrom /media/VirtualBoxGuestAdditions
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install gcc kernel-devel kernel-headers dkms make bzip2 perl
KERN_DIR=/usr/src/kernels/`uname -r`
export KERN_DIR
cd /media/VirtualBoxGuestAdditions
./VBoxLinuxAdditions.run
reboot
