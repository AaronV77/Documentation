#!/bin/sh

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1

else 

read -p "Name for the user: " user															# Git the name for the the hostname and to be able to move into directories.	

yum install epel-release																	# Get the latest repos for the centos operating system.
yum install iptables-services																# Enable iptable services to make sure that they are off for the lustre install.

systemctl stop firewalld																	# Turn off the firewall for the operating system.
systemctl disable firewalld																	# Disable the firewall so it doesn't start up on reboot

systemctl start iptables																	# Start the iptable services.
systemctl stop iptables																		# Turn off the iptables services.
systemctl disable iptables																	# Disable the iptables so that there is no chance of them turning on at boot.

nano /etc/sysconfig/selinux																	# Edit the selinux file and change the selinux to disabled. 						
ifup enp0s3																					# Make sure that the network device is running and up.
ifup enp0s8																					# Make sure that the network device is running and up.																							
hostnamectl set-hostname $user																# Set the hostname for the operating system.					

echo "																							
[lustre-server] 
name=CentOS-$releasever - Lustre 
baseurl= https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/
gpgcheck=0  

[e2fsprogs] 
name=CentOS-$releasever - Ldiskfs 
baseurl= https://downloads.hpdd.intel.com/public/e2fsprogs/1.42.13.wc6/el7/
gpgcheck=0 " > /etc/yum.repos.d/lustre.repo													# Create a new repo file for installing lustre.						

cd /home/$user/Downloads																	# Move to the downloads directory.
wget http://download.zfsonlinux.org/epel/zfs-release.el7_4.noarch.rpm						# Get the zfs repo.

yum localinstall zfs-release.el7_4.noarch.rpm												# Install the zfs repo.
yum upgrade e2fsprogs																		# Install the upgrades to e2fsprogs.
yum localinstall lustre-tests																# Install the Lustre Server.

reboot																						# Reboot the system.

fi


