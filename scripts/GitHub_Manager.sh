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
    git clone git@github.com:AaronV77/Documentation.git
    git clone git@github.com:AaronV77/Web.git
    git clone git@github.com:Algorithms.git
    git clone git@github.com:Thursday.git
    git clone git@github.com:quest.git
    git clone git@github.com:HydroShare.git
    git clone git@github.com:Python.git
    git clone git@github.com:User-Prompt-Input-Editor.git
    cd ..
    mv GitHub_Manager.sh GitHub_Repos/

else
    array=("Thursday" "Documentation" "Web" "Algorithms" "quest" "Python" "HydroShare" "User-Prompt-Input-Editor")
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
            git clone git@github.com:/AaronV77/"$i".git
        fi

    done

     
fi

echo
echo "**** ALL FINISHED ****"
echo 
