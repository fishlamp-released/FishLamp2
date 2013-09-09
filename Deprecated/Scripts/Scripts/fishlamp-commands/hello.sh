#!/bin/sh

#  HelloWorld.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 7/2/13.
#

function usage() {
    echo "prints a hello world string"
}

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi



echo "Hi there…"