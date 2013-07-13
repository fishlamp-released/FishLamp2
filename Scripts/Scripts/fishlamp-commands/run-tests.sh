#!/bin/sh

#  HelloWorld.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 7/2/13.
#

function usage() {
    echo "run unit tests"
}

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi

FAILED=""

cd "$HOME/Library/Developer/FishLamp/Tests"
FILES=`ls`
for test in $FILES; do
    echo "$test:"
    "./$test" | awk '{print "    "$0}' || { FAILED="YES"; }
    echo ""
done


if [[ "$FAILED" == "YES" ]]; then

    echo "FAILED!!"

    exit 1;
fi

exit 0;