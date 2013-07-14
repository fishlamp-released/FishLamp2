#!/bin/bash

function usage() {
    echo "increments FishLamp version, adds a git tag, commits, and pushes to remote origin"
}

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi


# fail if error
set -e

if [ ! -f ".fishlamp-root" ]; then
    echo "##! please run from root of fishlamp repo"
    exit 1;
fi

branch=`git rev-parse --abbrev-ref HEAD`

if [[ "$branch" != "master" ]]; then
    echo "##! please tag main branch, you're on $branch"
    exit 1;
fi

file="Version.plist"
header="Frameworks/Core/Classes/FishLampVersion.h"
packmule_version_file="Tools/PackMule/PackMule/Info.plist"

# bump the version
version=`plist-get-version $file`
version=`version-bump-build "$version"`

# set versions in file
plist-set-version "$file" "$version" > /dev/null 2>&1
plist-set-version "$packmule_version_file" "$version" > /dev/null 2>&1
git add "$file"
git add "$packmule_version_file"

echo "# updated version in $file and $packmule_version_file to $version"

# generate header file
echo "// version $version tagged $(DATE)" > "$header" 
echo "#ifndef FishLampVersion" >> "$header" 
echo "#define FishLampVersion @\"$version\"" >> "$header" 
echo "#endif" >> "$header" 
git add "$header" 

echo "# updated $header"

git commit -a -m "Tagged version $version"

tag="v$version"
git tag "$tag"
echo "# added tag \"$tag\""

git push --tags origin $branch 

echo "# all done"
