#!/bin/dash

FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")

if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".log ];then
	echo "The file '$FIC_NAME' is not under versioning, please use add."
	echo "$USAGE"
	exit 3
fi

nl "$FIC_PATH"/.version/"$FIC_NAME".log | sed 's/\([0-9]\)/\1:/'
exit 0