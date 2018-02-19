#!/bin/dash

USAGE="Usage: version.sh <command> file [option]\nWhere <command> can be: add checkout commit diff log revert rm"


if [ $# -lt 2 ]; then
    echo "Error: wrong number of arguments" >&2
    echo "$USAGE"
    exit 1
fi

case "$1" in
    ( "add" )
    	./add.sh $2;;
    ( "rm" )
        ./rm.sh $2;;
    ( "commit" )
        ./commit.sh $2;;
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

