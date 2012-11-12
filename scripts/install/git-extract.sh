#!/bin/bash

# http://stackoverflow.com/questions/359424/detach-subdirectory-into-separate-git-repository

dir=$1

if [ "$dir" == "" ]
	then
	echo "usage 'bash git-extract-dir.sh [dir]'"
	exit 0
fi

git remote rm origin
git filter-branch --subdirectory-filter "$dir" -- --all || { echo @"filter branch failed"; exit 1; }
git reset --hard
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
git reflog expire --expire=now --all
git gc --aggressive --prune=now

