#!/bin/dash

USAGE="Usage: version.sh diff file"


if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".1 ];then
	echo "The file '$FIC_NAME' is not under versioning, please use add."
	echo "$USAGE"
	exit 3
fi

diff -u "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest
exit 0