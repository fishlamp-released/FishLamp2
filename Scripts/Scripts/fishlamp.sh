#!/bin/bash

MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"

MY_PATH="$MY_PATH/fishlamp-commands"

if [ "$1" == "" ]; then
    echo "usage:"
    echo "    fishlamp COMMAND <parms>"
    echo ""
    echo "fishlamp commands:"
    "$MY_PATH/help.sh" -s | awk '{print "    "$0}'
    echo ""
    echo "try 'fishlamp help' for more info"
    echo ""
    exit 1
fi

MY_COMMAND="$1"
MY_SCRIPT="$MY_COMMAND.sh"
MY_PARMS=${*:2}

# echo "command = $COMMAND $PARMS"

if [ -f "$MY_PATH/$MY_SCRIPT" ]; then
    "$MY_PATH/$MY_SCRIPT" "$MY_PARMS"
else
    echo "unknown command \"$MY_COMMAND\""
    exit 1
fi

# echo "${*:2}"