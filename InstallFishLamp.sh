#!/bin/sh

#  FishLampSync.sh
#  Fluffy
#
#  Created by Mike Fullerton on 11/19/12.
#  Copyright (c) 2012 Mike Fullerton. All rights reserved.

# KEYWORDS="TODO:|FIXME:|\?\?\?:|\!\!\!:"
# find "${SRCROOT}" \( -name "*.h" -or -name "*.m" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($KEYWORDS).*\$" | perl -p -e "s/($KEYWORDS)/ warning: \$1/"

cd "$1"
INSTALL_DIR=`pwd`
FISHLAMP_SOURCE=""
FISHLAMP_DEST="$INSTALL_DIR/FishLamp"
SCRIPT_NAME="InstallFishlamp.sh"
FISHLAMP_RELATIVE_PATH=""

function verbose() {
	echo "$1"
}

function write_paths_file() {

    path="$FISHLAMP_DEST/FishLampPaths.xcconfig"
	version="// Version:16"
		
	if [ ! -f "$path" ]; then
	# make new empty file
		echo "" > "$path"
	fi	
		
	in_file=`grep "$version" "$path"`
	if [[ "$in_file" == "" ]]; then
	    echo "$version" > "$path"
	    echo "FISHLAMP = $FISHLAMP_RELATIVE_PATH/Frameworks" >> "$path"
	    echo "FISHLAMP_ALL = \$(FISHLAMP)/**" >> "$path"
	    echo "FISHLAMP_CORE = \$(FISHLAMP)/Core/**" >> "$path"
	    echo "FISHLAMP_COCOA = \$(FISHLAMP)/Cocoa/** \$(FISHLAMP)/CocoaUI/** \$(FISHLAMP)/Dependencies/** \$(FISHLAMP)/External/** \$(FISHLAMP)/Deprecated/** \$(FISHLAMP_CORE)" >> "$path"
	    echo "FISHLAMP_OSX = \$(FISHLAMP)/OSX/** \$(FISHLAMP_COCOA)" >> "$path"
	    echo "FISHLAMP_IOS = \$(FISHLAMP)/iOS/** \$(FISHLAMP_COCOA)" >> "$path"
	    echo "FISHLAMP_IOS_PHOTO = \$(FISHLAMP)/iOSPhoto/** \$(FISHLAMP_IOS)" >> "$path"

		echo "updated paths file: $path"
	else
		verbose "path file is up to date: $path"
	fi
}

function find_fishlamp() {
	cd "$INSTALL_DIR"

    local last_dir=""
    while [[ "$last_dir" != `pwd` ]]
    do
        if [ -f "FishLamp/$SCRIPT_NAME" ]; then
			cd "FishLamp" || { echo "unable to enter FishLamp"; exit 1; }
			FISHLAMP_SOURCE="`pwd`"
			FISHLAMP_RELATIVE_PATH="$FISHLAMP_RELATIVE_PATH"FishLamp
            verbose "found FishLamp: $FISHLAMP_SOURCE ($FISHLAMP_RELATIVE_PATH)"

		# pop back to origin dir
			cd "$INSTALL_DIR"
            return 0;
        fi

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
	rsync -avru --exclude ".git" --exclude ".DS_Store" "$FISHLAMP_SOURCE/Xcode/FishLamp" "$INSTALL_DIR" || { echo "error: unable to get module: $module"; exit 1; }
	cd "$FISHLAMP_DEST/Scripts"
	chmod +x *
}

function update_update_script() {
	
	local new_script="$INSTALL_DIR/UpdateFishLamp.sh"
	local old_script="$INSTALL_DIR/UpdateFishLamp"
	
	if [ -f "$old_script" ]; then
		rm "$old_script"
	fi
	
	update_str="bash \"$FISHLAMP_RELATIVE_PATH/$SCRIPT_NAME\" \"$INSTALL_DIR\""
	
	if [ ! -f "$new_script" ]; then
		echo "$update_str" > "$new_script"
		chmod +x "$new_script"
		verbose "updated update script"
	else
		
		in_file=`grep "$update_str" "$new_script"`
		if [[ "$in_file" == "" ]]; then
			echo "$update_str" > "$new_script"
			chmod +x "$new_script"
			verbose "updated update script"
		else
			verbose "update script is up to date"
		fi
	fi
	
}

function prepare_install() {
	if [[ "$INSTALL_DIR" == "" ]]; then 
		echo "expecting path argument to sync FishLamp folder"
		exit 1
	fi

	if [[ ! -d "$FISHLAMP_DEST" ]]; then
		mkdir "$FISHLAMP_DEST" || { echo "making \"$FISHLAMP_DEST\" failed"; exit 1; }
		verbose "created build folder: \"$FISHLAMP_DEST\""
	fi
}

prepare_install
find_fishlamp
sync_files
write_paths_file
update_update_script



				# echo > "bash \"$FISHLAMP_SOURCE/install_fishlamp.sh\" \"$FISHLAMP_DEST\"" > "$FISHLAMP_DEST/$sync_script_dest"

			#	ln -s "$FISHLAMP_SOURCE/$SCRIPT_NAME" "$sync_script_dest"
# sync_script_src=`type -P FishLampSync`
# # cp "$sync_script_src" "$sync_script_dest"
# 
# rsync -avru "$sync_script_src" "$sync_script_dest"




