#!/bin/sh

#  InstallFishLamp.sh
#
#  Created by Mike Fullerton on 11/19/12.
#  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
#  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 

# TODO: rewrite this in python or something, because this sucks.

DEST_FOLDER="$1"

if [[ "$DEST_FOLDER" == "" ]]; then 
	DEST_FOLDER=`pwd`
fi

cd "$DEST_FOLDER" || { echo "##! Unable find $DEST_FOLDER"; exit 1; }

FISHLAMP_RELATIVE_PATH=`fishlamp-find -r` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }

FISHLAMP_ROOT=`fishlamp-find -a` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }

# check source
BUILD_SUPPORT_PATH="$FISHLAMP_ROOT/Scripts/XcodeConfigs"
if [ ! -d "$BUILD_SUPPORT_PATH" ]; then
	echo "\"$BUILD_SUPPORT_PATH\" directory not found"
    exit 1;
fi

# remove dest
BUILD_SUPPORT_FOLDER_NAME="FishLampXcodeConfigs"
if [ -d "$BUILD_SUPPORT_FOLDER_NAME" ]; then
	rm -r "$BUILD_SUPPORT_FOLDER_NAME"
fi

# copy src into dest
cp -R "$BUILD_SUPPORT_PATH" "$BUILD_SUPPORT_FOLDER_NAME" || { "##! Installing FishLamp build files failed"; exit 1; }

# prepare to update paths in paths file
pathFile="$BUILD_SUPPORT_FOLDER_NAME/FishLampPaths.xcconfig"
tempFile="$BUILD_SUPPORT_FOLDER_NAME/FishLampPaths-temp.xcconfig"

# update paths in file into temp file
sed "s#FISHLAMP_RELATIVE_PATH#$FISHLAMP_RELATIVE_PATH#g" "$pathFile" > "$tempFile" || { echo "##! updating paths in $pathFile file failed"; exit 1; }

# promote temp file to real paths file
mv -f "$tempFile" "$pathFile" || { echo "##! updating paths in $pathFile file failed"; exit 1; }

echo "# Installed FishLampXcodeConfigs in $DEST_FOLDER"



