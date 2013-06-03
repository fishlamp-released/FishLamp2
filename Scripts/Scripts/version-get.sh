#!/bin/bash

plist_file="$1"

if [ "$plist_file" == "" ]; then
	echo "usage:"
	echo " version-get <plistfile>"
	exit 1
fi

if [ ! -f "$plist_file" ]; then
	echo "##! can't find plist file $plist_file"
	exit 1
fi

build_version=`/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" $plist_file` || { echo "##! CFBundleVersion not found in input file"; exit 1; }

if [ "$build_version" == "" ]; then
	echo "##! build version is empty"
	exit 1;
fi

echo "$build_version"

