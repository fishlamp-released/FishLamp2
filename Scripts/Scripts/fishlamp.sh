#!/bin/bash

function usage() {
    echo "prints help for fishlamp scripts"
}

if [ "$1" == "--help" ]; then
    usage
    exit 0;
fi

MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"

SUB_PATH="$MY_PATH/fishlamp-commands"

if [ "$1" == "" ]; then
    echo "commands:"

    FILES=`find "$MY_PATH" -type f -depth 1`
    for file in $FILES; do

        filename=$(basename "$file")

        echo "$filename" | awk '{print "    "$0}'
    done

    echo ""

    echo "fishlamp command parameters:"
    "$SUB_PATH/help.sh" -s | awk '{print "    "$0}'
    echo ""
    echo "try 'fishlamp help' for more info"
    echo ""

    exit 1
fi

MY_COMMAND="$1"
MY_SCRIPT="$MY_COMMAND.sh"
MY_PARMS=${*:2}

# echo "command = $COMMAND $PARMS"

if [ -f "$SUB_PATH/$MY_SCRIPT" ]; then
    "$SUB_PATH/$MY_SCRIPT" "$MY_PARMS"
else
    echo "unknown command \"$MY_COMMAND\""
    exit 1
fi

exit 0

