#!/bin/sh

#  version-bump-in-plist.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 7/14/13.
#

THE_FILE="$1"

function usage() {
    echo "updates build number in a plist file"
	echo "usage:"
	echo " version-plist-bump <plistfile>"
}

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi

if [ "$1" == "" ]; then
    usage
    exit 1;
fi

version=`plist-get-version "$THE_FILE"` || { exit 1; }

new_version=`version-bump-build "$version"` || { exit 1; }

new_version=`plist-set-version "$THE_FILE" "$new_version"` || { echo "failed"; exit 1; }

echo "$new_version"