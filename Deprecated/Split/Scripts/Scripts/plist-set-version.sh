#!/bin/sh

#  plist-set-version.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 6/5/13.
#

plist_file="$1"
version="$2"

function usage() {
    echo "sets version in a plist file"
	echo "usage:"
	echo " plist-set-version <plistfile> <version>"
}

if [ "plist_file" == "--help" ]; then
    usage
    exit 0;
fi

if [[ "$version" == "" ]]; then
    usage
    exit 1;
fi

if [ "$plist_file" == "" ]; then
    usage
	exit 1
fi

if [ ! -f "$plist_file" ]; then
	echo "##! can't find plist file: \"$plist_file\""
    exit 1
fi

DOTS=${version//[^\.]}

if [ ${#DOTS} != 3 ]; then
    echo "'$version' not in 1.2.3.4 format (found ${#DOTS} dots)"
    exit 1;
fi

`/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $version" $plist_file` || { echo "Setting CFBundleVersion failed"; exit 1; }
`/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $version" $plist_file` || { echo "Setting CFBundleShortVersionString failed"; exit 1; }

echo "$version"


exit 0

version=`plist-get-version "$plist_file"` || { exit 1; }

if [ "$version" == "" ]; then
	echo "##! build version is empty"
	exit 1;
fi


# parse build num from vers
build_num=${version##*.}

# parse version number without build number from vers
vers_base=${version%.*}

# increment build number (is there a better way to do this?)
build_num=`echo $build_num + 1 | bc`

# rebuild full version number
version="$vers_base.$build_num"
