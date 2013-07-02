#!/bin/sh

function usage() {
    echo "removes xcode cruft from git"
}

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi


function removeFiles() {
	FILES=`find . -type f -name "*xcuserdata"`

	for file in $FILES; do
		git rm --cached -r "$file"
	done
}

function removeDirs() {

	DIRS=`find . -type d -name "xcuserdata"`

	for dir in $DIRS; do
		rm -rd "$dir"
	done

}

removeFiles
removeDirs
