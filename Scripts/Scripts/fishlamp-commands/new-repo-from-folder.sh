#!/bin/bash

FOLDER="$1"
REPO_NAME="$2"
TEMP="$REPO_NAME-temp"

mkdir "$TEMP"

echo "copying fishlamp"
cp -R FishLamp "$TEMP/FishLamp"

cd "$TEMP"

mkdir "$REPO_NAME"
cd "$REPO_NAME"

git init
cp ../FishLamp/.gitignore .gitignore || { exit 1; }
cp ../FishLamp/LICENSE LICENSE || { exit 1; }
cp ../FishLamp/README.md README.md || { exit 1; }
git add -A
git commit -a -m "first commit"


# git-extract-directory


#pwd