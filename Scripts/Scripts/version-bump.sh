#!/bin/bash

plist_file="$1"

if [ "$plist_file" == "" ]; then
	echo "usage:"
	echo " version-bump <plistfile>"
	exit 1
fi

if [ ! -f "$plist_file" ]; then
	echo "##! can't find plist file $plist_file"
	exit 1
fi

build_version=`version-get "$plist_file"` || { exit 1; }

if [ "$build_version" == "" ]; then
	echo "##! build version is empty"
	exit 1;
fi

# parse build num from vers
build_num=${build_version##*.}

# parse version number without build number from vers
vers_base=${build_version%.*}

# increment build number (is there a better way to do this?)
build_num=`echo $build_num + 1 | bc`

# rebuild full version number
build_version="$vers_base.$build_num"

version-set "$plist_file" "$build_version"

exit 0

`/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $build_version" $plist_file` || { echo "Setting CFBundleVersion failed"; exit 1; }
`/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $build_version" $plist_file` || { echo "Setting CFBundleShortVersionString failed"; exit 1; }

echo "$build_version"
