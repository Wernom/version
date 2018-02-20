#!/bin/dash

FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")


mkdir "$FIC_PATH"/.version 2> /dev/null

if test -f "$FIC_PATH/.version/$FIC_NAME.1"; then
    echo "Error : File '$FIC_NAME' already exist"
    exit 4
fi


cp "$1" "$FIC_PATH"/.version/"$FIC_NAME".1
cp "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest
touch "$FIC_PATH"/.version/"$FIC_NAME".log
echo "Added a new file under versioning: '$1'"

exit 0




