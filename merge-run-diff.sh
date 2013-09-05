#!/bin/bash


function rundiff() {

#     open -e $*

    open diff $*
    pid=`ps -ax | grep FileMerge | awk '{print $1}' | head -1`
    nps=1
    while [ $nps -ne 0 ]
    do
    nps=`ps ax | grep $pid | grep -v "grep" | wc -l`
    done

}

function diff() {
    new="Pieces/${1:4}"
    old="OldPieces/$1"

    if [ -d "$new" ]; then


        src="" 
        dest="" 

        if [ -d "$old/Classes" ]; then
            src="$old/Classes"
            dest="$new/Classes"
        else
            src="$old"
            dest="$new"
        fi

        echo "# diffing $src into $dest"

        ksdiff --wait  "$src" "$dest"
        sleep 1
#         -merge "$dest" || { exit 1; }

#         opendiff "$src" "$dest" -merge "$dest" || { exit 1; }
# 
# #         open diff $*
#         pid=`ps -ax | grep FileMerge | awk '{print $1}' | head -1`
#         nps=1
#         while [ $nps -ne 0 ]
#         do
#         nps=`ps ax | grep $pid | grep -v "grep" | wc -l`
#         done

    
    else
        echo "$new"
    fi

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

files=`find OldPieces -depth 1 -name "Old-FishLamp-*"`

for file in $files; do
    name=`basename "$file"`
    diff "$name"
done
