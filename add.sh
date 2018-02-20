#!/bin/dash

FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")

if test ! -f "$1";then
    echo "Error : file '$FIC_PATH' does not exist"
    exit 1
fi


mkdir "$FIC_PATH"/.version 2> /dev/null

if test -f "$FIC_PATH/.version/$FIC_NAME.1"; then
    echo "Error : File '$FIC_NAME' already exist"
    exit 2
fi


cp "$1" "$FIC_PATH"/.version/"$FIC_NAME".1
cp "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest
echo "Added a new file under versioning: '$1'"




