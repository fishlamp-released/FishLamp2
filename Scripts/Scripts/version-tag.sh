#!/bin/bash

plist_file="$1"

if [ "$plist_file" == "" ]; then
	echo "usage:"
	echo "version-tag <plistfile>"
	exit 1
fi

if [ ! -f "$plist_file" ]; then
	echo "can't find plist file $plist_file"
	exit 1
fi

status=`git status -s`
branch=`git rev-parse --abbrev-ref HEAD`
build_version=`version-get "$plist_file"` || { exit 1; }

if [ "$status" != "" ]; then 
	echo "##! your git repo has uncommitted changes - please commit changes before tagging version."
	exit 1;
fi

if [ `fishlamp-ynq \"Bump version?\"` == "yes" ]; then
	echo "";
	version-bump "$plist_file" || { exit 1; }
	build_version=`version-get "$plist_file"` || { exit 1; }
	git add "$plist_file"
	git commit -a -m "new version: $build_version"
else 
	echo "";
fi

tag="v$build_version"
git tag $tag || { echo "##! adding git tag failed"; exit 1; }
echo "# added tag $tag ok"

if [ `fishlamp-ynq Push Changes?` == "yes" ]; then
	echo "";
	git push --tags origin $branch || { echo "##! pushing tag failed"; exit 1; }
else 
	echo "";
fi


