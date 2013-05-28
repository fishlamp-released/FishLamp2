#!/bin/sh

option="$1"

if [ "$option" != "-r" -a "$option" != "-a" ]; then
	echo "-r: relative path"
	echo "-a: absolute path"
	echo "usage:"
	echo "  fishlamp-find <-r -a>";
	exit 1;
fi

function verbose() {
#	echo "$1"
	noop=""
}

verbose ""
verbose "Looking for FishLamp..."

cd "$DEST_FOLDER"
FISHLAMP_RELATIVE_PATH=""
LAST_DIR=""
ROOT_FILE=".fishlamp-root"

while [[ "$LAST_DIR" != `pwd` ]]
do
	if [ -d "FishLamp" ]; then
		if [ -f "FishLamp/$ROOT_FILE" ]; then
			FISHLAMP_ROOT="`pwd`/FishLamp"
			FISHLAMP_RELATIVE_PATH="$FISHLAMP_RELATIVE_PATH"FishLamp
			
			if [ "$option" == "-r" ]; then
				echo "$FISHLAMP_RELATIVE_PATH";
			else 
				echo "$FISHLAMP_ROOT";
			fi
				
			exit 0;
		fi
	fi

	LAST_DIR=`pwd`
	cd ..
	FISHLAMP_RELATIVE_PATH="../$FISHLAMP_RELATIVE_PATH"
done

echo "FishLamp not found"
exit 1

