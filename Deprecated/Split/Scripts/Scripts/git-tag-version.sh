#!/bin/bash

function usage() {
    echo "bumps version, tags branch, pushes tags (and changes)"
	echo "usage:"
	echo " version-tag (-p) <plistfile> "
	exit 1
}

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi

plist_file=""
push=""

for var in "$@"
do
    if [[ "$var" == "-p" ]]; then 
        push="true"
    else
        plist_file="$var"
    fi
done

if [ "$plist_file" == "" ]; then
	usage
fi

if [ ! -f "$plist_file" ]; then
	echo "##! can't find plist file $plist_file"
	exit 1
fi

status=`git status -s`
branch=`git rev-parse --abbrev-ref HEAD`

if [ "$status" != "" ]; then 
	echo "##! your git repo has uncommitted changes - please commit changes before tagging version."
	exit 1;
fi

build_version=`plist-bump-version "$plist_file"` || { exit 1; }

git add "$plist_file" || { exit 1; }
git commit -a -m "new version: $build_version" || { exit 1; }

tag="v$build_version"
git tag $tag || { echo "##! adding git tag failed"; exit 1; }
echo "# added tag $tag ok"

if [ "$push" == "true" ]; then
	git push --tags origin $branch || { echo "##! pushing tag failed"; exit 1; }
else 
	echo "# don't forget to push:"
	echo "git push --tags origin $branch";
fi

exit 0


