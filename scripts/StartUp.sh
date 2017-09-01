#!/bin/bash
# This program is used to get the basic details of the current operating system. 

. /etc/lsb-release										# Takes the contents from the release file that is about the operating system.
OS=$DISTRIB_ID											# Saves the operating systems name.
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')		# Saves the architecture number of the operatin system.
VER=$DISTRIB_RELEASE									# Saves the version of the operating system.			

while true; do											# Loop until yes or no is given. This is so that we don't install torrent or any other programs.			
    read -p "Is this rework for personal use: " yn		# Take in the user input.
    case $yn in											# Take input and check				
        Yes|yes|Y|y) PSWITCH=$"ON"; break;;				# If the input is equal to one of the options then turn switch on.
        No|no|N|n) PSWITCH=$"OFF"; break;;							# If the input is equal to one of the options then turn switch off.
        * ) echo "Is this rework for personal use (no or yes): ";;	# Any other input that doesn't break the loop then keep asking.
    esac
done

while true; do											# Loop until yes or no is given. This is to check to see if we are using a virtualbox.			
    read -p "Is this virtual box: " yn					# Take in the user input.
    case $yn in											# Take input and check				
        Yes|yes|Y|y) VSWITCH=$"ON"; break;;				# If the input is equal to one of the options then turn switch on.
        No|no|N|n) VSWITCH=$"OFF"; break;;							# If the input is equal to one of the options then turn switch off.
        * ) echo "Is this rework for personal use (no or yes): ";;	# Any other input that doesn't break the loop then keep asking.
    esac
done

if [ $OS = "Ubuntu" ] 
then
	sudo apt-get update	&& sudo apt-get install -f		# Fetches the list of available updates.
	sudo apt-get upgrade							 	# Strictly upgraades the current packages.
	sudo apt-get dist-upgrade							# Installs updates (new ones).
	
	dpkg -s geany > check.txt							# Run the dpkg command to see if the application is installed, and output the contents to the the file.
	GEANY=$(grep Status: check.txt)						# Use grep to look in the file for the specific word choice.			
	
	if [ "$GEANY" != "Status: install ok installed" ]	# If the application is installed then move on else download.
	then
		sudo apt-get install geany						# Download geany.
	fi
		
	rm check.txt										# Remove the file from the hiearchy
	dpkg -s google-chrome-stable > check.txt			# Run the dpkg command to see if the application is installed, and output the contents to the file.
	CHROME=$(grep Status: check.txt)					# Use grep to look in the file for the specific word choice.
	
	if [ "$CHROME" != "Status: install ok installed" ]	# Check to see if the application is on the system.
	then
		wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - # Get the key and download the package.
		sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'	# Redirect the update source url to the source file.
		sudo apt-get update								# Update the system.
		sudo apt-get install google-chrome-stable		# Install the the download package.
		rm /etc/apt/sources.list.d						# Remove the second source file.										
	fi
	
	rm check.txt										# Remove the file.
	dpkg -s filezilla > check.txt						# Run the dpkg command to see if the application is installed, and output the contents to the file.
	FILEZILLA=$(grep Status: check.txt)					# Use grep to look in the file for the specific word choice.
	
	if [ "$FILEZILLA" != "Status: install ok installed" ]	# Check to see if the application is installed on the machine.
	then
		sudo apt-get install filezilla					# Install the application on the system if it is not already.
	fi
	
	rm check.txt
	dpkg -s flashplugin-installer > check.txt			# Run the dpkg command to see if the application is installed, and output the contents to the file.
	FLASH=$(grep Status: check.txt)						# Use grep to look in the file for the specific word choice.
	
	if [ "$FLASH" != "Status: install ok installed" ]   # Check to see if the application is installed on the machine.
	then
		sudo apt-get install flashplugin-installer		# Install the application on the system if it is not already.
	fi
	
	rm check.txt
	dpkg -s cmatrix > check.txt							# Run the dpkg command to see if the application is installed, and output the contents to the file.					
	MATRIX=$(grep Status: check.txt)					# Use grep to look in the file for the specific word choice.
	
	if [ "$MATRIX" != "Status: install ok installed" ]	# Check to see if the application is installed on the machine.
	then
		sudo apt-get install cmatrix					# Install the application on the system if it is not already.
	fi
	
	rm check.txt
	
	gsettings set com.canonical.Unity.Launcher launcher-position Bottom	# Move the navigation bar to the bottom of the screen.
	
	cd /usr/share/applications							# Change directories.
	mv ubuntu-amazon-default.desktop ../~ubuntu-amazon-default.desktop	# Comment out the file so that Amazon app / link is non-exsisting.
fi

reset
