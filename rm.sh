#!/bin/dash

FIC_NAME=$(basename "$1")

if test ! -f "$1";then
    echo "Error : file '$FIC_NAME' does not exist"
    exit 1
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
    for FIC in .version/$FIC_NAME*;do
        rm "$FIC"
        rmdir .version 2> /dev/null
    done
    echo "Everything was succesfully deleted"
    exit 0
fi

exit 0
