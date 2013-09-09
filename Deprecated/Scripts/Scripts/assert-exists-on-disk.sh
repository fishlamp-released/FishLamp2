#!/bin/sh

#  assert-exists-on-disk.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 7/14/13.
#

path="$1"
name="$2"
	
if [ ! -f "$path" -a ! -d "$path" ]; then
    echo "##! \"$path\" not found"
    exit 1
fi

exit 0;