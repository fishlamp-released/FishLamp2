#!/bin/sh

#  fishlamp-update-submodules.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 6/4/13.
#

FISHLAMP_RELATIVE_PATH=`fishlamp-find -r` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }

FISHLAMP_ROOT=`fishlamp-find -a` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }

cd "$FISHLAMP_ROOT"

git submodule init
git submodule update

cd fishlamp

branch=`git rev-parse --abbrev-ref HEAD`

git pull origin "$branch"

