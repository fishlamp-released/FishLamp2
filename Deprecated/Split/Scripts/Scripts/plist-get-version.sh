#!/bin/bash

plist_file="$1"

function usage() {
    echo "prints version from a plist file"
	echo "usage:"
	echo " plist-get-version <plistfile>"
}

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi

if [ "$plist_file" == "" ]; then
    usage
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

