#/bin/sh
echo
echo "***** Has all the repos been pushed! *****"
echo

while true; do		
    read -p "Are we setting up the directory? (y/n): " yn
    case $yn in			
        Y|y) PSWITCH=$"ON"; break;;
        N|n) PSWITCH=$"OFF"; break;;
        * ) echo "Install to the system? (y/n): ";;	
    esac
done

if [ "$yn" = "Y" ] || [ "$yn" = "y" ]
then
    
    mkdir GitHub_Repos
    cd GitHub_Repos
	git clone https://github.com/AaronV77/Lustre.git
    git clone https://github.com/AaronV77/Documentation.git
    git clone https://github.com/AaronV77/Web.git
    git clone https://github.com/AaronV77/Algorithms.git
    git clone https://github.com/AaronV77/Headers.git
    git clone https://github.com/AaronV77/Thursday.git
    cd ..
    mv GitHub_Manager.sh GitHub_Repos/

else
    array=("Thursday" "Lustre" "Documentation" "Web" "Headers" "Algorithms")
    for i in "${array[@]}"
    do
        echo
        echo "**** $i ****"
        echo

        if [ -d "$i" ]; 
        then
            cd $i/
            git checkout master
            git pull
            cd ..
        else 
            git clone https://github.com/AaronV77/"$i".git
        fi

    done

     
fi

echo
echo "**** ALL FINISHED ****"
echo 