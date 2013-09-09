#!/bin/sh

#  fishlamp-script-dir.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 7/2/13.
#
option="$1"

if [ "$option" == "--create" ]; then

    if [ ! -d "$HOME/Library/Developer" ]; then
        mkdir "$HOME/Library/Developer" || { echo "creating ~/Library/Developer folder failed"; exit 1; }
    fi

    if [ ! -d "$HOME/Library/Developer/FishLamp" ]; then
        mkdir "$HOME/Library/Developer/FishLamp" || { echo "creating ~/Library/Developer/FishLamp folder failed"; exit 1; }
    fi

    if [ ! -d "$HOME/Library/Developer/FishLamp/Scripts" ]; then
        mkdir "$HOME/Library/Developer/FishLamp/Scripts" || { echo "creating ~/Library/Developer/FishLamp/Scripts folder failed"; exit 1; }
    fi
fi

echo "$HOME/Library/Developer/FishLamp/Scripts"