
#!/bin/bash

pwd
read -p "Repository destionation on computer (Full Path): " repoPath	# Get to where the repo is located.
while true; do															# Loop until yes or no is given. This is so that we don't install torrent or any other programs.			
    read -p "Are we adding all the files (yes/no): " yn					# Take in the user input.
    case $yn in															# Take input and check				
        Yes|yes|Y|y) PSWITCH=$"ON"; break;;								# If the input is equal to one of the options then turn switch on.
        No|no|N|n) PSWITCH=$"OFF"; break;;								# If the input is equal to one of the options then turn switch off.
        * ) echo "(no or yes): ";;										# Any other input that doesn't break the loop then keep asking.
    esac
done

cd $repoPath																# Move to the directory of where the 
if [ $PSWITCH == "ON" ]													# If the user wants to add all the files again.
then
	echo ""
	echo "Multi-Threaded_Linked_List: ssh - git@github.com:AaronV77/Multi-Thread_Linked_List.git"
	echo "Number_Generator: ssh - git@github.com:AaronV77/Number_Generator.git"
	echo "Standard_Matching_Algorithm: ssh - git@github.com:AaronV77/Standard_Matching_Algorithm.git"
	echo "Depth_And_Breadth_First_Search_Algorithm: ssh - git@github.com:AaronV77/Depth_And_Breadth_First_Search_Algorithm.git"
	echo "Dijkstras_Algorithm: ssh - git@github.com:AaronV77/Dijkstras_Algorithm.git"
	echo "Headers: ssh - git@github.com:AaronV77/Headers.git"
	echo "Documentation: ssh - git@github.com:AaronV77/Documentation.git"
	echo""
	read -p "Commit message: " commitMessage								# Get the commit message.	
	read -p "GitHub Repo. URL: " repoURL									# Get the GitHub ssh download.
	git add --all
	git commit -am "$commitMessage"										# Make the commit.		
	git remote add origin $repoURL										# Connect to the repository.
	git push origin master												# Push the contents to GitHub.
else
	echo "git add (file)"
	echo "git commit -am (commit meesage)"
	echo ""
	echo "Multi-Threaded_Linked_List: ssh - git@github.com:AaronV77/Multi-Thread_Linked_List.git"
	echo "Number_Generator: ssh - git@github.com:AaronV77/Number_Generator.git"
	echo "Standard_Matching_Algorithm: ssh - git@github.com:AaronV77/Standard_Matching_Algorithm.git"
	echo "Depth_And_Breadth_First_Search_Algorithm: ssh - git@github.com:AaronV77/Depth_And_Breadth_First_Search_Algorithm.git"
	echo "Dijkstras_Algorithm: ssh - git@github.com:AaronV77/Dijkstras_Algorithm.git"
	echo "Headers: ssh - git@github.com:AaronV77/Headers.git"
	echo "Documentation: ssh - git@github.com:AaronV77/Documentation.git"
	echo ""
	echo "git remote add origin (reopo url)"
	echo "git push origin master"
fi
