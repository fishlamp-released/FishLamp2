#!/bin/bash

MY_PATH="`dirname \"$0\"`"              
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  

INSTALL_PATH="/usr/local/fishlamp"

echo ""
echo "A couple of things:"
echo "1. The script will run sudo, so you'll need enter your password."
echo "   This is because this script copies files to /usr/local/fishlamp and uses 'sudo' to do this."
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
	exit 0;
fi

echo ""

cd "$MY_PATH/Scripts"

# reset install folder
if [ -d "$INSTALL_PATH" ]; then
	sudo rm -r "$INSTALL_PATH"
fi

sudo mkdir "$INSTALL_PATH" || { echo "unable to create folder: $INSTALL_PATH"; exit 1; }
sudo chmod u+rwx "$INSTALL_PATH" || { echo "unable to change permissions on: $INSTALL_PATH"; exit 1; }

# install scripts

FILES=`ls`
for file in $FILES; 
	do
		extension=${file##*.}
		if [[ "$extension" == "sh" ]]
		then
			filename_no_extension=`basename "$file" .sh`

			src="`pwd`/$file"
			dest="$INSTALL_PATH/$filename_no_extension"
			
			sudo cp "$src" "$dest" || { echo "unable to copy script to: $dest"; exit 1; }
			sudo chmod u+rx "$dest" || { echo "unable to change permissions on: $dest"; exit 1; }
			
			echo "# installed: \"$dest\""
		fi
done

# update bash profile

sed -i -e "/usr\/local\/fishlamp/d" ~/.bash_profile 
echo "export PATH=\"\$PATH:$INSTALL_PATH\"" >> ~/.bash_profile

echo "# updated: $HOME/.bash_profile"
echo ""
echo "Please restart your terminal session"
echo ""
echo "Hint: command \"fishlamp\" will list the scripts installed here."
echo ""

exit 0

