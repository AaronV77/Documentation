#!/bin/bash
# This program is used to get the basic details of the current operating system. 

. /etc/lsb-release										# Takes the contents from the release file that is about the operating system.
OS=$DISTRIB_ID											# Saves the operating systems name.
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')		# Saves the architecture number of the operatin system.
VER=$DISTRIB_RELEASE									# Saves the version of the operating system.			

if [ $OS = "Ubuntu" ] 
then
	sudo apt-get update	&& sudo apt-get install -f		# Fetches the list of available updates.
	sudo apt-get upgrade							 	# Strictly upgraades the current packages.
	sudo apt-get dist-upgrade							# Installs updates (new ones).
	# sudo apt-get install geany							# Download geany.
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - # Get the key and download the package.
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'	# Redirect the update source url to the source file.
	sudo apt-get update									# Update the system.
	sudo apt-get install google-chrome-stable			# Install the the download package.
	rm /etc/apt/sources.list.d							# Remove the second source file.										
	sudo apt-get install git							# Install git features.
	git config --global user.name "AaronV77"			# Setup the username for GitHub.
	git config --global user.email "aaronvaloroso77@gmail.com" # Setup the email for GitHub.
	sudo apt-get install filezilla						# Install the application on the system if it is not already.
	sudo apt-get install flashplugin-installer			# Install the application on the system if it is not already.
	sudo apt-get install cmatrix						# Install the application on the system if it is not already.
	curl -O https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
	chmod 777 ./Anaconda3-4.2.0-Linux-x86_64.sh
	./Anaconda3-4.2.0-Linux-x86_64.sh
	export PATH=~/anaconda3/bin:$PATH
	conda update --prefix /home/valorosoa/anaconda3 anaconda
	gsettings set com.canonical.Unity.Launcher launcher-position Bottom	# Move the navigation bar to the bottom of the screen.
	cd /usr/share/applications											# Change directories.
	mv ubuntu-amazon-default.desktop ../~ubuntu-amazon-default.desktop	# Comment out the file so that Amazon app / link is non-exsisting.
	# git clone https://www.github.com/codebrainz/geany-themes
	# cd /geany-themes
	# ./install.sh
fi

# Add the follwoing to the script but in comments:
# CoreUtils Installs
# Other Linux Shells
# Latex applications

reset
reboot

# Becareful some Ubuntu versions are on life cycles and end life. 
# So if things are not updating then that Image has lost support.

# If the setup for git fails to be able to clone then you might have to do the following.
# ssh-keygen -t rsa -C "your email for GitHub"
# cd ~/.ssh
# nano id_rsa.pub (Copy the contents of the file and add it to the SSH Key's in the GitHub Account Settings
# ssh-add
