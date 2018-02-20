#!/bin/dash

USAGE="Usage: version.sh <command> file [option]\nWhere <command> can be: add checkout commit diff log revert rm"

FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")

if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".1 ];then
	echo "The file '$FIC_NAME' is not under versioning, please use add."
	echo "$USAGE"
	exit 3
fi

diff -u "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest
exit 0