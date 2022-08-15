#!/bin/bash

clear
echo " hi this is good by burger"
echo ""
read -p "To continue press [ENTER], or Ctrl-C to exit"

title_bar() {
        clear
        echo"AME WIN"
}

title_bar
sudo apt update
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' git|grep "install ok installed")
echo "Checking for git: $PKG_OK"
if [ "" == "$PKG_OK" ]; then
        echo "curl not found, prompting to install git..."
        sudo apt-get -y install git
        
fi
PKG_OK=$(dpkg-query -W --showformat='$Status}\n' p7zip-full|grep "install ok installed")
echo "Checking for 7zip: $PKG_OK"
if [ "" == "$PKG_OK" ]; then
        echo "curl not found, Prompting to install 7zip..."
        sudo apt-get -y install p7zip-full
fi

title_bar
echo "fzf is required for this script to function"
echo "Please Allow for fzf to install following message"
echo "Enter 'y' (yes) for all prompts"
read -p "To continue press [Enter], or Ctrl-C to exit"
echo "\n"
title_bar
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

title_bar
echo "Starting AME process, searching for files..."
Term=(applocker autologger clipsvc clipup DeliveryOptimization DeviceCensus.exe diagtrack dmclient dosvc EnhancedStorage homegroup hotspot invagent msra sihclient slui startupscan storsvc usoapi usoclient usocore usocoreworker usosvc WaaS windowsmaps windowsupdate wsqmcons wua wus)
touch fzf_list.txt
for i in "${Term[@]}"
do
    echo "Looking for $i"
    $HOME/.fzf/bin/fzf -e -f $i >> fzf_list.txt
done

title_bar
if [ -s fzf_list.txt ]
then
    echo "Directory file not empty, continuing..."
else
    echo "ERROR! no files found, exiting..."
    exit 1  
fi

rm dirs*
touch dirs.txt

awk '!/FileMaps/' fzf_list.txt > fzf_list_cleaned1.txt

sed 's%/[^/]*$%/%' fzf_list_cleaned.txt >> dirs.txt

for a in {0..12..2}
do
    if [ $a -eq 0 ]
    then
        cat dirs.txt > dirs$a.txt
    fi
    b=$((a+1))
    c=$((b+1))
    sed 's,/$,,' dirs$a.txt >> dirs$b.txt
    sed 's%/[^/]*$%/%' dirs$b.txt >> dirs$c.txt
    cat dirs$c.txt >> dirs.txt
done
