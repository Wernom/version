#!/bin/dash

if test ! -f "$1";then
    echo "Error : file $1 does not exist"
<<<<<<< HEAD
    exit 1
fi
=======
fi


mkdir $(dirname $1)/.version
cp $1 $(dirname $1)/.version/$(basename $1).1
cp $1 $(dirname $1)/.version/$(basename $1).last
echo "Added a new file under versioning: '$1'"




>>>>>>> 4bf74025ccc4afd0a61ce8a76d95989fa50e9130
