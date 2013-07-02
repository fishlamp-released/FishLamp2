#!/bin/bash

MY_PATH="`dirname \"$0\"`"              
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  

bash "$MY_PATH/bin/fishlamp-install-scripts.sh" || { echo "install failed"; exit 1; }

exit 0

INSTALL_PATH="$HOME/Library/FishLamp/Scripts"

echo ""
echo "A couple of things:"
echo "1. The script will run sudo, so you'll need enter your password."
echo "   This is because this script copies files to $HOME/FishLamp/Scripts and uses 'sudo' to do this."
echo "   The script itself will not ask for you password (only sudo will)"
echo
echo "2. The script adds /usr/local/fishlamp to PATH so you can run the scripts from the terminal."
echo "   The scripts adds this to your .bash_profile file" 
echo ""

read -p "Is this ok? (y or n): " -n 1 -r

echo ""

if [[ $REPLY =~ ^[Nn]$ ]]
then
    echo "ok"
    exit 1;
fi

echo ""

bash "$MY_PATH/bin/fishlamp-install-scripts.sh" || { echo "install failed"; exit 1; }

