#!/bin/sh

#  fishlamp-version.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 6/22/13.
#

function usage() {
    echo "prints current version of fishlamp"
}

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi


MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  

FISHLAMP_RELATIVE_PATH=`fishlamp find -r` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }
FISHLAMP_ROOT=`fishlamp find -a` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }

version-get "$FISHLAMP_ROOT/Version.plist"