#!/bin/dash

FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")



if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".1 ];then
	echo "Error: The file '$FIC_NAME' is not under versioning, please use add." >&2
	echo "$USAGE" >&2
	exit 3
fi

while test "$CHOICE" != "no" && test "$CHOICE" != "yes";do
    echo "Are you sure you want to delete '$FIC_NAME' from versioning? (yes/no)"
    echo -n ">" 
    CHOICE=$(cat)
    echo "\n"
done

if test "$CHOICE" = "no";then
    echo "Deletion aborted"
    exit 0
fi

if test "$CHOICE" = "yes";then
    for FIC in "$FIC_PATH"/.version/"$FIC_NAME"*;do
        rm "$FIC"
        rmdir "$FIC_PATH"/.version 2> /dev/null
    done
    echo "'$FIC_NAME' is not under versioning anymore."
    exit 0
fi

exit 0
