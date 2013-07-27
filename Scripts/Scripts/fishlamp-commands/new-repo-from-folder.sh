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

function prepare_fishlamp() {

    local fishlamp_original="$1"
    local folder_to_extract="$2"

    if [ ! -d "$fishlamp_original" ]; then
        echo "$fishlamp_original not found"
        exit 1;
    fi

    echo "copying fishlamp"
    cp -R "$fishlamp_original" "FishLamp" || { echo "copying fishlamp failed"; exit 1; }

    pushd "FishLamp"

    git checkout develop

    

    # http://stackoverflow.com/questions/359424/detach-subdirectory-into-separate-git-repository
    git remote rm origin
    git filter-branch --subdirectory-filter "$folder_to_extract" -- --all || { echo @"filter branch failed"; exit 1; }
    git reset --hard
    git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
    git reflog expire --expire=now --all
    git gc --aggressive --prune=now

    popd
}

function create_new_repo() {
    local repo="$1"

    mkdir "$repo"
    pushd "$repo"

    git init
    cp ../FishLamp/.gitignore .gitignore || { exit 1; }
    cp ../FishLamp/LICENSE LICENSE || { exit 1; }
    cp ../FishLamp/README.md README.md || { exit 1; }
    git add -A
    git commit -a -m "first commit"

    echo "git repo created at: \"$repo\" - don't forget to add a remote origin"

    popd
}

function main() {
    local repo_name="$1"
    local folder_to_extract="$2"

    temp_dir="temp-$repo_name"
    mkdir "$temp_dir"
    pushd "$temp_dir"

    prepare_fishlamp "../FishLamp" "$folder_to_extract"

    create_new_repo "$repo_name"
    popd
}

main "$1" "$2"

# git-extract-directory


#pwd