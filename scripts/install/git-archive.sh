#!/bin/bash

repo="$1"

cd "$repo"
git branch -a

for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
    git branch --track ${branch##*/} $branch
done

git pull --all
git branch -a

git bundle create "$repo".bundle --all

mv "$repo".bundle ..