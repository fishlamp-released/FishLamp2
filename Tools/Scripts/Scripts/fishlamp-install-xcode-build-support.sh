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

BUILD_SUPPORT_FOLDER_NAME="FishLampBuildSupport"

# echo "# Installing or Updating \"$DEST_FOLDER/$BUILD_SUPPORT_FOLDER_NAME\""

if [ -d "$BUILD_SUPPORT_FOLDER_NAME" ]; then
	rm -r "$BUILD_SUPPORT_FOLDER_NAME"
fi

cp -R "$FISHLAMP_ROOT/XcodeSupport/$BUILD_SUPPORT_FOLDER_NAME" "." || { "##! Installing FishLamp build files failed"; exit 1; }

pathFile="$BUILD_SUPPORT_FOLDER_NAME/FishLampPaths.xcconfig"
tempFile="$BUILD_SUPPORT_FOLDER_NAME/FishLampPaths-temp.xcconfig"

sed "s#FISHLAMP_RELATIVE_PATH#$FISHLAMP_RELATIVE_PATH#g" "$pathFile" > "$tempFile" || { echo "##! updating paths in $pathFile file failed"; exit 1; }

mv -f "$tempFile" "$pathFile" || { echo "##! updating paths in $pathFile file failed"; exit 1; }

echo "# Installed FishLampBuildSupport in $DEST_FOLDER"



