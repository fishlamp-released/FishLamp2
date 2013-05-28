#!/bin/bash

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

while [ "$done" == "no" ]; do

	read -p "$prompt (ynq): " -n 1 -r; echo ""

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "yes"
		exit 0
	elif [[ $REPLY =~ ^[Nn]$ ]]; then
		echo "no";
		exit 0
	elif [[ $REPLY =~ ^[Qq]$ ]]; then
		echo "quit";
		exit 1
	fi

done

exit 1