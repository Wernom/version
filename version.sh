#!/bin/dash

USAGE="Usage: version.sh <command> file [option]\nWhere <command> can be: add checkout commit diff log revert rm"


if [ $# -lt 2 ]; then
    echo "Error: wrong number of argument" >&2
    echo "$USAGE"
    exit 1
fi

case "$1" in
    ( "add" )
        echo "add";;
    ( "rm" )
        echo "rm";;
    ( "commit" )
        echo "commit";;
    ( "revert" )
        echo "revert"
    ( "diff" )
        echo "diff";;
    ( "checkout" )
        echo "checkout";;
    ( "log" )
        echo "log";;
    ( * )
        echo "Error: this command name does not exist : $1"
        echo "$USAGE"
        exit 2;;
esac
