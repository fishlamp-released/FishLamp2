#!/bin/sh

#  install.sh
#  FishLampCocoaTests
#
#  Created by Mike Fullerton on 11/24/12.
#  Copyright (c) 2012 Mike Fullerton. All rights reserved.

file="$1"
dest="$HOME/Library/Developer/FishLamp/"

cp -f "$file" "$dest"
cp -f -r "$file.dSYM" "$dest"

ls "$dest"
