#!/bin/bash

function diff() {
    new="Pieces/$1"
    old="OldPieces/Old-$1"
    echo "# diffing $old into $new"

    ksdiff --wait "$old" "$new"
}

# diff FishLamp-Core
# diff FishLamp-ActivityLog
# diff FishLamp-Networking
# diff FishLamp-Async
# diff FishLamp-Encoding
# diff FishLamp-Persistance
# diff FishLamp-Authentication
# diff FishLamp-Strings/Classes $cocoa_module/Strings
# diff FishLamp-ModelObject/Classes $cocoa_module/ModelObject
# diff FishLamp-Test/Classes $cocoa_module/Testing
# diff FishLamp-CodeGenerator/Classes	monolith/Frameworks/CodeGenerator
# 

files=`find Pieces -depth 1 -name "FishLamp-*"`

for file in $files; do
        
    name=`basename "$file"`

    

    diff "$name"

done
