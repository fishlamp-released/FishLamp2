#!/bin/bash

if [ ! -f ".fishlamp-root" ]; then
    echo "please run from root of fishlamp repo"
    exit 1;
fi

branch=`git rev-parse --abbrev-ref HEAD`

if [[ "$branch" != "master" ]]; then
    echo "please tag main branch"
    exit 1;
fi
