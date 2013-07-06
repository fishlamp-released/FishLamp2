#!/bin/sh

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
