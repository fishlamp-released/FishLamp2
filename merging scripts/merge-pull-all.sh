#!/bin/bash

cd Pieces
files=`find . -depth 1 -name "FishLamp-*"`

for file in $files; do
    cd "$file"
    git pull 
    cd ..
done
