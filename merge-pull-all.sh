#!/bin/bash

cd merge
files=`find . -depth 1 -name "FishLamp-*"`

for file in $files; do
    cd "$file"
    git pull 
    cd ..
done
