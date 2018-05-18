#!/bin/sh

read -p "Please give me the username for the machine: " user
read -p "Is this a client machine (y/n): " client
read -p "Is this a server machine (y/n): " server

yum update
yum install epel-release
systemctl stop firewalld
systemctl disable firewalld
yum install iptables-services
systemctl start iptables
systemctl stop iptables

echo "Disable Selinux: "
nano /etc/sysconfig/selinux

echo "Edit Hosts"
nano /etc/hosts

echo "Edit the network script file, this should not be blank"
nano /etc/sysconfig/network-scripts/ifcfg-enp0s8
ifup enp0s8

hostnamectl set-hostname $user

echo "[e2fsprogs]
name=CentOS-$releasever - Ldiskfs
baseurl=https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS
gpgcheck=0" > /etc/yum.repos.d/lustre.repo

cd /home/$user/Downloads
wget http://download.zfsonlinux.org/epel/zfs-release.el7_4.noarch.rpm
yum upgrade e2fsprogs

if [ "$client" == "y" & "$server" == "n"] then

    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/client/RPMS/x86_64/kmod-lustre-client-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/client/RPMS/x86_64/kmod-lustre-client-tests-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/client/RPMS/x86_64/lustre-client-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/client/RPMS/x86_64/lustre-client-tests-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/client/RPMS/x86_64/lustre-iokit-2.10.0-1.el7.x86_64.rpm

else if [ "$server" == "y" & "$client" == "n"] then

    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/RPMS/x86_64/kernel-3.10.0-514.21.1.el7_lustre.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/RPMS/x86_64/kernel-headers-3.10.0-514.21.1.el7_lustre.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/RPMS/x86_64/kmod-lustre-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/RPMS/x86_64/kmod-lustre-osd-ldiskfs-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/RPMS/x86_64/kmod-lustre-osd-zfs-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/RPMS/x86_64/kmod-lustre-tests-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/RPMS/x86_64/lustre-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/RPMS/x86_64/lustre-iokit-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/RPMS/x86_64/lustre-osd-ldiskfs-mount-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/RPMS/x86_64/lustre-osd-zfs-mount-2.10.0-1.el7.x86_64.rpm
    wget https://downloads.hpdd.intel.com/public/lustre/latest-release/el7/server/RPMS/x86_64/lustre-tests-2.10.0-1.el7.x86_64.rpm

    yum localinstall zfs-release.el7_4.noarch.rpm
    yum localinstall kernel-headers-3.10.0-514.21.1.el7_lustre.x86_64.rpm
    yum localinstall kernel-3.10.0-514.21.1.el7_lustre.x86_64.rpm
    yum localinstall lustre-osd-ldiskfs-mount-2.10.0-1.el7.x86_64.rpm
    yum localinstall kmod-lustre-2.10.0-1.el7.x86_64.rpm
    yum localinstall kmod-lustre-osd-ldiskfs-2.10.0-1.el7.x86_64.rpm
    yum localinstall lustre-osd-zfs-mount-2.10.0-1.el7.x86_64.rpm
    yum localinstall lustre-osd-zfs-mount-2.10.0-1.el7.x86_64.rpm
    yum localinstall lustre-iokit-2.10.0-1.el7.x86_64.rpm
    yum localinstall lustre-2.10.0-1.el7.x86_64.rpm
    yum localinstall lustre-tests-2.10.0-1.el7.x86_64.rpm

else

  echo "Sorry could not tell if this is suppose to be a server or client machine."

fi
