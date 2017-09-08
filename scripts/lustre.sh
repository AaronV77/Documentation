#!/bin/sh

read -p "Name for the user: " user
yum update
yum install epel-release
yum install iptables-services

systemctl stop firewalld
systemctl disable firewalld
systemctl start iptables
systemctl stop iptables
systemctl disable iptables


nano /etc/sysconfig/selinux
ifup enp0s3
ifup enp0s8
hostnamectl set-hostname $user

echo "[lustre-server] 
name=CentOS-$releasever - Lustre 
baseurl= https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/
gpgcheck=0  

[e2fsprogs] 
name=CentOS-$releasever - Ldiskfs 
baseurl= https://downloads.hpdd.intel.com/public/e2fsprogs/1.42.13.wc6/el7/
gpgcheck=0  

[lustre-client] 
name=CentOS-$releasever – Lustre 
baseurl= https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/client/ 
gpgcheck=0" > /etc/yum.repos.d/lustre.repo

cd /home/$user/Downloads
wget http://download.zfsonlinux.org/epel/zfs-release.el7_4.noarch.rpm

yum install zfs-release.el7_4.noarch.rpm
yum upgrade e2fsprogs
