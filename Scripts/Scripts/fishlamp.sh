#!/bin/bash

libpath="/usr/local/fishlamp"

function list() {
	echo "tools available in: \"$libpath\""
	ls -G -p "$libpath"
}

list