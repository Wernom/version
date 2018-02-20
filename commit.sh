#!/bin/dash

USAGE="Usage: version.sh commit file 'comment'"

if [ ! -f "$1" ];then
	echo "The file $1 does not exist"
	exit 1
fi

if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".1 ];then
	echo "The file '$FIC_NAME' is not under versioning, please use add."
	echo "$USAGE"
	exit 3
fi

NB_VERSION=-1

for VAR in $FIC_PATH/.version/$FIC_NAME.*;do
	NB_VERSION=$((NB_VERSION+1)) #No quote
done

NEW_VERSION=$(diff "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest)

if [ -z "$NEW_VERSION" ];then
	echo "The latest version is the same as $FIC_NAME"
	exit 5
fi

if [ -z "$2" ];then
	echo "Please comment"
	exit 9
fi

diff "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest > "$FIC_PATH"/.version/"$FIC_NAME"."$NB_VERSION"
cp "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest
echo "$(date -R)" "$2" >> "$FIC_PATH"/.version/"$FIC_NAME".log


echo "Committed a new version: $NB_VERSION"
exit 0


