#!/bin/sh

#  fishlamp-version.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 6/22/13.
#

FISHLAMP_RELATIVE_PATH=`fishlamp-find -r` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }
FISHLAMP_ROOT=`fishlamp-find -a` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }

version-get "$FISHLAMP_ROOT/Version.plist"