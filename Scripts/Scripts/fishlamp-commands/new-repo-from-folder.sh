#!/bin/bash

function usage() {
    echo "usage:"
    echo "    fishlamp new-repo-from-folder [path to folder in FishLamp] [new repo name]"
}

function help() {
    echo "copy folder from fishlamp into a new repo"
    echo "FishLamp should be cloned and set to develop branch in directory you're running this command from"
    echo "You'll need to create the repo on github and then set the remote origin on the new repo this script creates"
    echo "new repo will be created in \"temp-[new repo name]\""
    echo ""
    usage
}

if [ "$1" == "--help" ]; then
    help
    exit 0;
fi

if [ "$1" == "" ]; then
    echo "no param 1"
    usage
    exit 1;
fi

if [ "$2" == "" ]; then

    echo "no param 2, p1 = $1"
    usage
    exit 1;
fi

folder_to_extract="$1"
repo_name="$2"

original_fishlamp="`( cd \"FishLamp\" && pwd )`"
if [ ! -d "$original_fishlamp" ]; then
    echo "$original_fishlamp not found"
    exit 1;
fi

temp_fishlamp="`pwd`/$repo_name-source"

# prepare fishlamp
echo "copying fishlamp"
cp -R "$original_fishlamp" "$temp_fishlamp" || { echo "copying fishlamp to $temp_fishlamp failed"; exit 1; }

pushd "$temp_fishlamp" > /dev/null

git checkout develop

# http://stackoverflow.com/questions/359424/detach-subdirectory-into-separate-git-repository
git remote rm origin
git filter-branch --subdirectory-filter "$folder_to_extract" -- --all || { echo @"filter branch failed"; exit 1; }
git reset --hard
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
git reflog expire --expire=now --all
git gc --aggressive --prune=now

git clean -d -f
git clean -f

popd > /dev/null

# create new repo

mkdir "$repo_name"
pushd "$repo_name" > /dev/null

git init
touch "hello-world"
git add -A
git commit -a -m "first commit"

git branch develop
git checkout develop

git remote add -f temp "$temp_fishlamp" || { exit 1; }
git merge -s ours --no-commit temp/develop || { exit 1; }
# git read-tree --prefix="$folder_to_extract" -u temp/develop || { exit 1; }
git read-tree --prefix="/" -u temp/develop || { exit 1; }
git remote rm temp
git rm "hello-world"
git commit -a -m "imported files from FishLamp"

cp "$original_fishlamp/.gitignore" .gitignore || { exit 1; }
cp "$original_fishlamp/LICENSE" LICENSE || { exit 1; }
cp "$original_fishlamp/README.md" README.md || { exit 1; }
git add -A
git commit -a -m "updated boilerplate files"

#	if [ "$new_repo" == "." ]; then
#		git read-tree --prefix="/" -u "$temp_remote"/"$old_branch" || { remove_remote; exit 1; }
#	else
#		git read-tree --prefix="$new_repo/" -u "$temp_remote"/"$old_branch" || { remove_remote; exit 1; }
#	fi

echo "git repo created at: \"$repo_name\" - don't forget to add a remote origin"

popd > /dev/null

sudo rm -R "$temp_fishlamp"

