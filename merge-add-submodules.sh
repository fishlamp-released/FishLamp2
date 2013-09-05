#!/bin/bash

file="module-list.txt"

while IFS= read line ; do
    if [ ! -d "Pieces/$line" ]; then
        git submodule add https://www.github.com/fishlamp/$line Pieces/$line || { exit 1; }
    fi
done <"$file"