#!/bin/bash


MY_PATH="`dirname \"$0\"`"              
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  
INSTALL_PATH="/usr/local/fishlamp"

cd "$MY_PATH/../scripts"

# reset install folder
if [ -d "$INSTALL_PATH" ]; then
	sudo rm -rd "$INSTALL_PATH"
fi

sudo mkdir "$INSTALL_PATH" || { echo "unable to create folder: $INSTALL_PATH"; exit 1; }
sudo chmod u+rwx "$INSTALL_PATH" || { echo "unable to change permissions on: $INSTALL_PATH"; exit 1; }

# install scripts


SOURCE_PATH=`pwd`

FILES=`ls`
for file in $FILES; do
    src="$SOURCE_PATH/$file"
    dest="$INSTALL_PATH/$file"
    
    extension=${file##*.}
    if [[ "$extension" == "sh" ]]; then
        filename_no_extension=`basename "$file" .sh`
        dest="$INSTALL_PATH/$filename_no_extension"
    fi

    sudo cp -R "$src" "$dest" || { echo "unable to copy script to: $dest"; exit 1; }
    echo "# installed: \"$dest\""
done

sudo chmod -R 755 "$INSTALL_PATH" || { echo "unable to change permissions on: $INSTALL_PATH"; exit 1; }

# update bash profile

sudo sed -i -e "/usr\/local\/fishlamp/d" ~/.bash_profile 
echo "export PATH=\"\$PATH:$INSTALL_PATH\"" >> ~/.bash_profile

echo "# updated: $HOME/.bash_profile"
echo ""
echo "Please restart your terminal session"
echo ""
echo "Hint: command \"fishlamp\" will list the scripts installed here."
echo ""

exit 0

