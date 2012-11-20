#!/bin/sh

#  FishLampSync.sh
#  Fluffy
#
#  Created by Mike Fullerton on 11/19/12.
#  Copyright (c) 2012 Mike Fullerton. All rights reserved.

# KEYWORDS="TODO:|FIXME:|\?\?\?:|\!\!\!:"
# find "${SRCROOT}" \( -name "*.h" -or -name "*.m" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\$" | perl -p -e "s/($KEYWORDS)/ warning: \$1/"

fishlamp="$1"

if [ "$fishlamp" == "" ]
then
    echo "error: no path to FishLamp passed in. Example: \"FishLampSync.sh ..\..\FishLamp\"" 
    exit 1
fi

fishlamp=`cd "$fishlamp"; pwd`

if [ ! -d "$fishlamp" ] 
then
    echo "error: $fishlamp not found"
    exit 1
else
    echo "Found FishLamp! ($fishlamp)"
fi


if [ ! -d "FishLamp" ]
then
    mkdir FishLamp || { echo "error: unable to create FishLamp folder"; exit 1; }
    echo "Created FishLamp folder"
fi

function sync2() {
    
    local path="$1"
	echo "$path"
    
    if [ -d "$path" ]
    then
        mkdir "$path$item"
    fi

    local items=`ls $path`
    for item in $items
	do
        item_path="$path$item"
    
        if [ -d "$item_path" ]
        then
            sync2 "$item_path/"
        else
            echo "$item_path"

            ln -f -s "$item_path" "$item"
        fi
	done
}

function sync_module() {
    module="$1"
    dest="$2"
    echo "  "
    echo "## Syncing \"$fishlamp/$1\" to \"`pwd`/FishLamp/$2\"..."
    
    rsync -avru --exclude ".git" --exclude ".DS_Store" "$fishlamp/$module" "FishLamp/$dest/" || { echo "error: unable to get module: $module"; exit 1; }

    echo "## Sync was successfull."

#	sync2 "$fishlamp/$module"

}

sync_module XcodeConfigs/ XcodeConfigs

echo "Done"

	

exit 0

sync_module Core/Classes/Core/ Core
sync_module Core/Classes/Testing/ Testing
sync_module OSX/CommandLineTool/Classes/ CommandLineTool


rsync -avru --exclude ".git" $fishlamp/Core/Classes/Core/ FishLamp/Core/
rsync -avru --exclude ".git" $fishlamp/Core/Classes/Testing/ FishLamp/Testing/
rsync -avru --exclude ".git" $fishlamp/CommandLineTool/Classes/ FishLamp/CommandLineTool/
