#!/bin/sh

#  fishlamp-create-connect-lib.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 6/4/13.
#

FISHLAMP_RELATIVE_PATH=`fishlamp-find -r` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }
FISHLAMP_ROOT=`fishlamp-find -a` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }


if [ "$1" == "" ]; then
	echo "usage:"
	echo " fishlamp-create-connect-lib <ProjectName>"
	exit 1
fi

PROJECT_NAME="$1"
CONNECT_DIR="$FISHLAMP_ROOT/Frameworks/Connect"


cp -R "$FISHLAMP_ROOT/Frameworks/templates/CONNECT_TEMPLATE" "$CONNECT_DIR/$PROJECT_NAME" || { echo "unable to copy template"; exit 1; }

REPLACE_ME="CONNECT_TEMPLATE"

FILES=`grep -r -l "$REPLACE_ME" *`

for file in $FILES; do
    
    echo "peforming replace in $file"
       
    tempFile="$file-temp"

    # update paths in file into temp file
    sed "s#REPLACE_ME#$PROJECT_NAME#g" "$file" > "$tempFile" || { echo "##! updating project name in $file file failed"; exit 1; }

    echo "updating tempfile to $file"

    # promote temp file to real paths file
    mv -f "$tempFile" "$file" || { echo "##! updating $file failed"; exit 1; }
       
done


echo "# Created new connect library for $PROJECT_NAME"