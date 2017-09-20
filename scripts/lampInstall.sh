#!/bin/bash

var=$(id)

if [ "$var" == "uid=0(root) gid=0(root) groups=0(root)" ]
then
	
	while true; do											# Loop until yes or no is given. This is so that we don't install torrent or any other programs.			
		read -p "Install Wordpress (y/n): " wordPress		# Take in the user input.
		case $wordPress in											# Take input and check				
			Y|y) PSWITCH=$"ON"; break;;						# If the input is equal to one of the options then turn switch on.
			N|n) PSWITCH=$"OFF"; break;;					# If the input is equal to one of the options then turn switch off.
			* ) echo "Install Wordpress (y/n): ";;			# Any other input that doesn't break the loop then keep asking.
		esac
	done	
	
	while true; do											# Loop until yes or no is given. This is so that we don't install torrent or any other programs.			
		read -p "Install phpAdmin (y/n): " phpAdmin			# Take in the user input.
		case $phpAdmin in											# Take input and check				
			Y|y) PSWITCH=$"ON"; break;;						# If the input is equal to one of the options then turn switch on.
			N|n) PSWITCH=$"OFF"; break;;					# If the input is equal to one of the options then turn switch off.
			* ) echo "Install phpAdmin (y/n): ";;			# Any other input that doesn't break the loop then keep asking.
		esac
	done
	
	
	sudo apt-get install apache2
	sudo apt-get install mysql-client mysql-server
	sudo mysql_secure_installation 
	sudo apt-get install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd 
	sudo ufw stop
	sudo ufw disable
	sudo systemctl start apache2.service
	sudo systemctl enable apache2.service
	sudo nano /etc/apache2/mods-enabled/dir.conf 
	#~ Edit the DirectoryIndex and put index.php first of the list (comma seperated string)
	sudo systemctl restart apache2.service
	sudo nano /etc/php/7.0/apache2/php.ini
	#~ Edit the diable_functions, and put phpinfo.
	sudo systemctl restart apache2.service
	
	if [ wordPress == "y" ] || [ wordPress == "Y" ]
	then
		echo "############################### WORDPRESS  ############################### "
		cd /home/username/Downloads
		wget -c http://wordpress.org/latest.tar.gz
		tar -xzvf latest.tar.gz
		sudo rsync -av wordpress/* /var/www/html/
		sudo chown -R www-data:www-data /var/www/html/
		sudo chmod -R 755 /var/www/html/
		cd /var/www/html
		echo "- mysql> CREATE DATABASE wp_myblog;"
		echo "- mysql> GRANT ALL PRIVILEGES ON wp_myblog.* TO 'your_username_here'@'localhost' identified by 'your_chosen_password_here';"
		echo "- mysql> FLUSH PRIVILEGES;"
		echo "- mysql> EXIT;"
		mysql -u root -p
		sudo mv wp-config-sample.php wp-config.php
		sudo nano wp-config.php
		sudo systemctl restart apache2.service 
		sudo systemctl restart mysql.service 
		sudo service networking 
	fi
	
	if [ phpAdmin == "y" ] || [ phpAdmin == "Y" ]
	then
		echo "############################### PHPMYADMIN  ############################### "
		sudo apt-get install phpmyadmin
		sudo nano /etc/apache2/apache2.conf
		sudo systemctl restart apache2.service 
		sudo systemctl restart mysql.service 
		sudo service networking 
	fi
	
	reboot
	
else 
	
	echo "***Please become root***"

fi



