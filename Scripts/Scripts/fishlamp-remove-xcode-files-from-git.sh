#!/bin/sh

FILES=`find . -name "*xcuserdata"`

for item in "$FILES"; do
	git rm --cached -r "$item"
done
