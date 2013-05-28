#!/bin/bash

libpath="/usr/local/fishlamp"

function list() {
	# FILES=`ls $libpath`
	# for file in $FILES; 
	# do
	# 	echo " $file"
	# done
	echo "tools available in: \"$libpath\""
	ls -G -p "$libpath"
}

function usage() {
	echo "workflow [-o -l]"
	echo " -o = open"
	echo " -l = list scripts"
}

function open() {
	cd $libpath
	. open . || { echo "## Error: can't open \"$libpath\""; exit 1; }

	# echo "open doesn't work."
}

if [ "$1" == "-o" ] 
	then
	open
	exit 0
fi

if [ "$1" == "-l" ] 
	then
	list
	exit 0
fi

if [ "$1" == "-?" ] 
	then
	usage
	exit 0
fi

if [ "$1" == "e" ] 
	then
	echo "hello"
	echo "cd \"$HOME/enlistments\"" > "/$libpath/open-enlistments.sh"
	source "$libpath/open-enlistments.sh"                   
	exit 0
fi

list