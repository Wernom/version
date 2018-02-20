#!/bin/dash

USAGE="Usage: version.sh checkout file number"
FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")

if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".1 ];then
	echo "Error : the file '$FIC_NAME' is not under versioning, please use add."
	echo "$USAGE"
	exit 3
fi

test "$2" -lt 0 2> /dev/null

if test $? -gt 1 ;then
    echo "Error : the argument must be a number"
    echo "$USAGE"
    exit 8
fi 

if test "$2" -lt 0;then
    echo "Error : the argument must be greater than 0"
    echo "$USAGE"
    exit 8
fi

if test ! -f "$FIC_PATH"/.version/"$FIC_NAME"."$2";then
    echo "Error : this version doesn't exist"
    echo "Use log to learn about the existing version"
    echo "$USAGE"
    exit 10
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
