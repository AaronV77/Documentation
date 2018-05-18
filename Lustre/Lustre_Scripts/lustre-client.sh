#!/bin/sh

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1

else 

read -p "Name for the user: " user

nano /etc/sysconfig/selinux																	# Edit the selinux file and change the selinux to disabled. 						
ifup enp0s3																					# Make sure that the network device is running and up.
ifup enp0s8																					# Make sure that the network device is running and up.																							
hostnamectl set-hostname $user																# Set the hostname for the operating system.	

cd /home/$user/Downloads																	# Change to the download directory.
wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.10.1/el7/client/RPMS/x86_64/kmod-lustre-client-2.10.1-1.el7.x86_64.rpm	# Download the lustre client software.
wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.10.1/el7/client/RPMS/x86_64/lustre-client-2.10.1-1.el7.x86_64.rpm

yum localinstall kmod-lustre-client-2.10.1-1.el7.x86_64.rpm									# Install the lustre client software.
yum localinstall lustre-client-2.10.1-1.el7.x86_64.rpm
reboot																						# Reboot the system.

fi

