#!/bin/sh

#  install.sh
#  FishLampCocoaTests
#
#  Created by Mike Fullerton on 11/24/12.
#  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 

file="$1"
dest="$HOME/Library/Developer/FishLamp/"

cp -f "$file" "$dest"
cp -f -r "$file.dSYM" "$dest"

ls "$dest"
