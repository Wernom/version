#!/bin/dash

FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")


mkdir "$FIC_PATH"/.version 2> /dev/null

if test -f "$FIC_PATH/.version/$FIC_NAME.1"; then
    echo "Error: File named '$FIC_NAME' has already been added"
    exit 4
fi


cp "$1" "$FIC_PATH"/.version/"$FIC_NAME".1
cp "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest

#If there is no comment, we add 'Add to versioning' for the first version added
if [ -z "$2" ];then
    echo "$(date -R)" "Add to versioning" > "$FIC_PATH"/.version/"$FIC_NAME".log
    echo "Added a new file under versioning: '$1'"
    exit 0
fi

echo "$(date -R)" "$2" > "$FIC_PATH"/.version/"$FIC_NAME".log
echo "Added a new file under versioning: '$1'"
exit 0




