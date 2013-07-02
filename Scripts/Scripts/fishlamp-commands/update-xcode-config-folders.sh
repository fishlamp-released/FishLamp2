#!/bin/sh

function usage() {
    echo "updates all of the FishLampXodeConfig folders in this folder and all it's child folders"
}

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi

dir="$1"

if [[ "$dir" == "" ]]; then
	dir=`pwd`
fi

cd "$dir"

echo "#"
echo "# Looking for UpdateFishLamp scripts in $dir"
echo "#"

for dir in `find . -name "FishLampXcodeConfigs"`; do
	
	pushd "$dir/.." >> /dev/null 

	fishlamp-install-xcode-build-support || { echo "##! updating \"`pwd`\" failed"; exit 1; }
	
	popd >> /dev/null 
done

echo "#"
echo "# done"
echo "#"
