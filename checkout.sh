#!/bin/dash

USAGE="Usage: version.sh <command> file [option]\nWhere <command> can be: add checkout commit diff log revert rm"
FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")

if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".1 ];then
	echo "The file '$FIC_NAME' is not under versioning, please use add."
	echo "$USAGE"
	exit 3
fi

if test "$2" -lt 0;then
    echo "The argument must be greater than 0"
    exit 8
fi 

#We begin from the first file commited and we patch the file .
cp "$FIC_PATH"/.version/"$FIC_NAME".1 "$1"

if test "$2" = 1;then
    exit 0
fi


for COUNT in $(seq 2 "$2");do
    patch -R "$1" "$FIC_PATH"/.version/"$FIC_NAME"."$COUNT" > /dev/null
done

exit 0
