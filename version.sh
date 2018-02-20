#!/bin/dash

USAGE="Usage: version.sh <command> file [option]\nWhere <command> can be: add checkout commit diff log revert rm"

if [ $# -lt 2 ]; then
    echo "Error: wrong number of arguments" >&2
    echo "$USAGE"
    exit 1
fi

if test ! -f "$2";then
    echo "Error : file '$FIC_NAME' does not exist"
    exit 2
fi

case "$1" in
    ( "add" )
    	./add.sh "$2" "$3";;
    ( "rm" )
        ./rm.sh "$2";;
    ( "commit" )
        ./commit.sh "$2" "$3";;
    ( "ci" )
        ./commit.sh "$2";;
    ( "revert" )
        ./revert.sh "$2";;
    ( "diff" )
        ./diff.sh "$2";;
    ( "checkout" )
        ./checkout.sh "$2" "$3";;
    ( "co" )
        ./checkout.sh "$2" "$3";;
    ( "log" )
        ./log.sh "$2";;
    ( * )
        echo "Error: this command name does not exist : $1"
        echo "$USAGE"
        exit 6;;
esac

exit 0

