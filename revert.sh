#!/bin/dash

USAGE="Usage: version.sh <command> file [option]\nWhere <command> can be: add checkout commit diff log revert rm"

FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")

#check if the file has already been versioned
if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".latest ];then
	echo "The file '$FIC_NAME' is not under versioning, impossible to revert."
	echo "$USAGE"
	exit 1
fi

DIFF=$(diff "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest)

if [ -z "$DIFF" ];then
    echo "The latest version is the same as $FIC_NAME"
    exit 2
fi

cp "$FIC_PATH"/.version/"$FIC_NAME".latest "$1"
echo "Reverted to the latest version"
exit 0




