#!/bin/bash

function usage() {
    echo "prompts user for y/n answer"
}

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi


prompt=""

for var in "$@"
do
	if [ "$prompt" == "" ]; then
		prompt="$var"
	else
		prompt="$prompt $var"
	fi

done

done="no"

read -p "$prompt (Y, N, Q): " -n 1 -r

while [ "$done" == "no" ]; do

	if [[ $REPLY =~ ^[Yy]*$ ]]; then
		echo ""
		echo "yes"
		exit 0
	elif [[ $REPLY =~ ^[Nn]*$ ]]; then
		echo ""
		echo "no";
		exit 0
	elif [[ $REPLY =~ ^[Qq]*$ ]]; then
		echo ""
		echo "quit";
		exit 1
	else
		read -n 1 -r
	fi


done

exit 1