#!/bin/sh

#  fishlamp-create-connect-lib.sh
#  FishLampScripts
#
#  Created by Mike Fullerton on 6/4/13.
#

FISHLAMP_RELATIVE_PATH=`fishlamp-find -r` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }
FISHLAMP_ROOT=`fishlamp-find -a` || { echo "##! FishLamp not found. Must be in current or parent directory."; exit 1; }


if [ "$1" == "" ]; then
	echo "usage:"
	echo " fishlamp-create-connect-lib <ProjectName>"
	exit 1
fi

PROJECT_NAME="$1"
CONNECT_DIR="$FISHLAMP_ROOT/Frameworks/Connect"

NEW_DIR="$CONNECT_DIR/$PROJECT_NAME"

cp -R "$FISHLAMP_ROOT/Frameworks/XcodeTemplates/CONNECT_TEMPLATE" "$NEW_DIR" || { echo "unable to copy template"; exit 1; }


cd "$NEW_DIR"

for file in `find . -d -type d -name "*xcuserdata*"`; do
    rm -rd "$file" || { echo "removing user data failed"; exit 1; }
    echo "deleted $file"
done

echo "rename dirs"

function rename_dirs() {

    pushd "$1"

    for dir in `find . -type d -d 1 -name "*CONNECT_TEMPLATE*"`; do
        mv "$dir" "${dir//CONNECT_TEMPLATE/$PROJECT_NAME}" || { echo "dir rename failed"; exit 1; }
    done
    
    for dir in `find . -type d -d 1`; do
        rename_dirs "$dir"
    done
    
    popd

}

rename_dirs "$NEW_DIR"

echo "rename files"




#rename files
for file in `find . -name "*CONNECT_TEMPLATE*"`; do
    mv "$file" "${file//CONNECT_TEMPLATE/$PROJECT_NAME}" || { echo "File rename failed"; exit 1; }
done

echo "perform text replace"

for file in `grep -r -l "CONNECT_TEMPLATE" *`; do
    
    echo "peforming replace in $file"
       
    tempFile="$file-temp"

    # update paths in file into temp file
    sed "s#CONNECT_TEMPLATE#$PROJECT_NAME#g" "$file" > "$tempFile" || { echo "##! updating project name in $file file failed"; exit 1; }

    echo "updating tempfile to $file"

    # promote temp file to real paths file
    mv -f "$tempFile" "$file" || { echo "##! updating $file failed"; exit 1; }
       
done


echo "# Created new connect library for $PROJECT_NAME"

exit 0


#rename dirs
for dir in `find "$NEW_DIR" -type d -name "*CONNECT_TEMPLATE*"`; do
    echo "$dir"

    mv "$dir" "${dir//CONNECT_TEMPLATE/$PROJECT_NAME}" || { echo "dir rename failed"; exit 1; }
done
