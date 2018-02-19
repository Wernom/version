#!/bin/dash

if test ! -f "$1";then
    echo "Error : file '$(basename "$1")' does not exist"
    exit 1
fi



mkdir $(dirname $1)/.version
cp $1 $(dirname $1)/.version/$(basename $1).1
cp $1 $(dirname $1)/.version/$(basename $1).latest
echo "Added a new file under versioning: '$1'"




