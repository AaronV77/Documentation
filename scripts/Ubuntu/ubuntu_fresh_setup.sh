#!/bin/bash
# This program is used to get the basic details of the current operating system. 

. /etc/lsb-release										# Takes the contents from the release file that is about the operating system.
OS=$DISTRIB_ID											# Saves the operating systems name.
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')		# Saves the architecture number of the operatin system.
VER=$DISTRIB_RELEASE									# Saves the version of the operating system.			

if [ $OS = "Ubuntu" ] 
then
	# Get the machine up-to-date and setup.
	sudo apt-get update	&& sudo apt-get install -f
	sudo apt-get upgrade
	sudo apt-get dist-upgrade
	gsettings set com.canonical.Unity.Launcher launcher-position Bottom
	cp /usr/share/applications/ubuntu-amazon-default.desktop /usr/share/applications/~ubuntu-amazon-default.desktop
	rm /usr/share/applications/ubuntu-amazon-default.desktop
	mv /usr/share/applications/~ubuntu-amazon-default.desktop /usr/share/applications

	# Install Geany and other color packages.
	# sudo apt-get install geany
	# git clone https://www.github.com/codebrainz/geany-themes
	# cd /geany-themes
	# ./install.sh	

	# Process for setuping and installing chrome.
	# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	# sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	# sudo apt-get update
	# sudo apt-get install google-chrome-stable
	# rm /etc/apt/sources.list.d

	# Setup git
	sudo apt-get install git
	git config --global user.name ""
	git config --global user.email ""

	# Get other shells
	# sudo apt-get install zsh
	# sudo apt-get install csh
	# sudo apt-get install ksh

	# For Latex
	sudo apt-get install texlive-full
	sudo apt-get install texmaker
	
	# Other Packages
	sudo apt-get install filezilla
	sudo apt-get install flashplugin-installer
	sudo apt-get install cmatrix	

	# For Anaconda and Python 3.6
	curl -O https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
	chmod 777 ./Anaconda3-4.2.0-Linux-x86_64.sh
	./Anaconda3-4.2.0-Linux-x86_64.sh
	conda update conda
	# export PATH=~/anaconda3/bin:$PATH

fi

# Add the follwoing to the script but in comments:
# CoreUtils Installs

reset
reboot

# Notes:

# Becareful some Ubuntu versions are on life cycles and end life. 
# So if things are not updating then that Image has lost support.

# If the setup for git fails to be able to clone then you might have to do the following.
# ssh-keygen -t rsa -C "your email for GitHub"
# cd ~/.ssh
# nano id_rsa.pub (Copy the contents of the file and add it to the SSH Key's in the GitHub Account Settings
# ssh-add
