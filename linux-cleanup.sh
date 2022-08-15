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
echo "Starting
