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

bump=`fislamp-ynq \"Bump version?\"` || { exit 1; }


if [ `fislamp-ynq \"Bump version?\"` == "yes" ]; then
	echo "hi";
fi

exit 0;

if [ "$bump" == "yes" ]; then 
	version-bump "$plist_file" || { exit 1; }
	build_version=`version-get "$plist_file"` || { exit 1; }
	git add "$plist_file"
	git commit -a -m "new version: $build_version"
fi

tag="v$build_version"
git tag $tag || { echo "##! adding git tag failed"; exit 1; }

read -p "Push Changes? (y or n): " -n 1 -r; echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
	git push --tags origin $branch || { echo "##! pushing tag failed"; exit 1; }
elif [[ $REPLY =~ ^[Nn]$ ]]; then
	echo "no pushing";
else
	echo "##! huh?"; 
	exit 1;
fi

echo "# added tag $tag ok"
