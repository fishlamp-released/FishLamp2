#!/bin/bash

version="$1"
which="$2"

if [ "$version" == "" ]; then
    echo "increments version build number by 1"

	echo "usage:"
	echo " version-bump <1.2.3.4>"
	exit 1
fi

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi

DOTS=${version//[^\.]}
if [ ${#DOTS} != 3 ]; then
    echo "'$version' not in 1.2.3.4 format (found ${#DOTS} dots)"
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

echo "$version"
