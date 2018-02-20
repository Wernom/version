#!/bin/dash

USAGE="Usage: version.sh commit file 'comment'"

if [ ! -f "$1" ];then
	echo "Error: The file $1 does not exist"
	exit 1
fi

FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")

if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".1 ];then
	echo "Error: The file '$FIC_NAME' is not under versioning, please use add." >&2
	echo "$USAGE" >&2
	exit 3
fi

#Count the number of version of a specified file. We beggin by -1 because of the log and the latest file.
NB_VERSION=-1
for VAR in $FIC_PATH/.version/$FIC_NAME.*;do
	NB_VERSION=$((NB_VERSION+1)) #No quote
done

NEW_VERSION=$(diff "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest)

if [ -z "$NEW_VERSION" ];then
	echo "Error: The latest version is the same as $FIC_NAME" >&2
	exit 5
fi

if [ -z "$2" ];then
	echo "Error: Please comment" >&2
	echo "$USAGE"
	exit 9
fi

diff "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest > "$FIC_PATH"/.version/"$FIC_NAME"."$NB_VERSION"
cp "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest
echo "$(date -R)" "$2" >> "$FIC_PATH"/.version/"$FIC_NAME".log


echo "Committed a new version: $NB_VERSION"
exit 0

