#!/bin/dash

USAGE="Usage: version.sh diff file"

FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")

if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".1 ];then
	echo "Error: The file '$FIC_NAME' is not under versioning, please use add."
	echo "$USAGE"
	exit 3
fi

diff -u "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest

if test $? -eq 0;then
	echo "No difference found"
fi

exit 0