#!/bin/sh

#  FishLampSync.sh
#  Fluffy
#
#  Created by Mike Fullerton on 11/19/12.
#  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 

# KEYWORDS="TODO:|FIXME:|\?\?\?:|\!\!\!:"
# find "${SRCROOT}" \( -name "*.h" -or -name "*.m" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\$" | perl -p -e "s/($KEYWORDS)/ warning: \$1/"

cd "$1" || { echo "$1 is invalid directory"; exit 1; }

INSTALL_DIR=`pwd`

if [[ "$INSTALL_DIR" == "" ]]; then 
	echo "expecting path argument to sync FishLamp folder"
	exit 1
fi
function verbose() {
#	echo "$1"
	noop=""
}

FISHLAMP_SOURCE=""
FOLDER_NAME="FishLampBuildSupport"
FISHLAMP_DEST="$INSTALL_DIR/$FOLDER_NAME"
SCRIPT_NAME="InstallFishlamp.sh"
FISHLAMP_RELATIVE_PATH=""

verbose "Updating FishLamp in \"$FISHLAMP_DEST\""

function write_paths_file() {
    path="$FISHLAMP_DEST/FishLampPaths.xcconfig"
	echo "" > "$path"
    echo "FISHLAMP = $FISHLAMP_RELATIVE_PATH/Frameworks" >> "$path"
    echo "FISHLAMP_ALL = \$(FISHLAMP)/**" >> "$path"
    echo "FISHLAMP_CORE = \$(FISHLAMP)/Core/**" >> "$path"
    echo "FISHLAMP_COMPATIBILITY = \$(FISHLAMP)/Compatibility/** \$(FISHLAMP_CORE)" >> "$path" 
	echo "FISHLAMP_COCOA = \$(FISHLAMP)/Cocoa/** \$(FISHLAMP)/Dependencies/** \$(FISHLAMP)/External/** \$(FISHLAMP)/Deprecated/** \$(FISHLAMP_COMPATIBILITY)" >> "$path"
	
    echo "FISHLAMP_COCOA_UI = \$(FISHLAMP)/CocoaUI/** \$(FISHLAMP_COCOA)" >> "$path"
    
    echo "// OSX" >> "$path"
    echo "FISHLAMP_OSX = \$(FISHLAMP)/OSX/** \$(FISHLAMP_COCOA_UI)" >> "$path"
    
    echo "// IOS" >> "$path"
    echo "FISHLAMP_IOS = \$(FISHLAMP)/iOS/** \$(FISHLAMP_COCOA_UI)" >> "$path"
    
    echo "// Addons" >> "$path"
    echo "FISHLAMP_CONNECT = \$(FISHLAMP)/Connect/**" >> "$path"
	echo "FISHLAMP_SUBMODULES = \$(FISHLAMP_RELATIVE_PATH)/Submodules/**" >> "$path"
	echo "FISHLAMP_COCOS2D = \$(FISHLAMP)/../Submodules/cocos2d" >> "$path"
    echo "FISHLAMP_COCOS2D_MAC = \$(FISHLAMP_COCOS2D)/cocos2d \$(FISHLAMP_COCOS2D)/cocos2d/Platforms \$((FISHLAMP_COCOS2D)/cocos2d/Platforms/Mac " >> "$path"
    echo "FISHLAMP_ANIMATION_MAC = \$(FISHLAMP)/Animation/** \$(FISHLAMP_COCOS2D_MAC) \$(FISHLAMP_COCOS2D)/external/**" >> "$path"
    
	verbose "Updated $path ok"
}

function find_fishlamp() {
	
	verbose ""
	verbose "Looking for FishLamp..."
	
	cd "$INSTALL_DIR"
	FISHLAMP_RELATIVE_PATH=""
    local last_dir=""

    while [[ "$last_dir" != `pwd` ]]
    do
		if [ -d "FishLamp" ]; then
			if [ -f "FishLamp/$SCRIPT_NAME" ]; then
				FISHLAMP_SOURCE="`pwd`/FishLamp"
				FISHLAMP_RELATIVE_PATH="$FISHLAMP_RELATIVE_PATH"FishLamp
	            verbose "FishLamp: $FISHLAMP_SOURCE"
				verbose "Install Dir: $INSTALL_DIR"
				verbose "FishLamp Relative Path: $FISHLAMP_RELATIVE_PATH"

			# pop back to origin dir
				cd "$INSTALL_DIR"
				verbose ""
				
	            return 0;
			fi
		fi
	
	
		#         if [ -f "FishLamp/$SCRIPT_NAME" ]; then
		# 	cd "FishLamp" || { echo "unable to enter FishLamp"; exit 1; }
		# 	FISHLAMP_SOURCE="`pwd`"
		# 	FISHLAMP_RELATIVE_PATH="$FISHLAMP_RELATIVE_PATH"FishLamp
		#             verbose "found FishLamp: $FISHLAMP_SOURCE ($FISHLAMP_RELATIVE_PATH)"
		# 
		# # pop back to origin dir
		# 	cd "$INSTALL_DIR"
		#             return 0;
		#         fi

        last_dir=`pwd`
        cd ..
		FISHLAMP_RELATIVE_PATH="../$FISHLAMP_RELATIVE_PATH"
    done

	
	if [ "$FISHLAMP_SOURCE" == "" ]
	then
	    echo "error: unable to find FishLamp folder. (Looking for /FishLamp/FishLamp.xcworkspace)" 
	    exit 1
	fi
	

}

function sync_files() {
	cd "$INSTALL_DIR"
	
	if [ -d "$FOLDER_NAME" ]; then
		rm -r "$FOLDER_NAME"
	fi
	
	cp -R "$FISHLAMP_SOURCE/$FOLDER_NAME" "." || { "Installing FishLamp build files failed"; exit 1; }
	
	echo "FISHLAMP=\"$FISHLAMP_RELATIVE_PATH\"" > "$FOLDER_NAME/FishLampRelativePath.sh"
	
	verbose "Installed FishLamp Build files ok"
}

find_fishlamp
sync_files
write_paths_file

echo "# Installed FishLampBuildSupport in $INSTALL_DIR"
