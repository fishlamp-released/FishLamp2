#!/bin/bash

function usage() {
	echo "usage:"
	echo " version-tag [-p -b] <plistfile> "
	echo " -p = push"
	exit 1
}

plist_file=""
bump=""
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
	usage
	exit 1
fi

status=`git status -s`
branch=`git rev-parse --abbrev-ref HEAD`
build_version=`version-get "$plist_file"` || { exit 1; }

if [ "$status" != "" ]; then 
	echo "##! your git repo has uncommitted changes - please commit changes before tagging version."
	exit 1;
fi

build_version=`version-bump-build "$build_version"` || { exit 1; }
version-set "$plist_file" "$build_version" || { exit 1; } 
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


