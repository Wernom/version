#!/bin/dash

USAGE="Usage: version.sh <command> file [option]\nWhere <command> can be: add checkout commit diff log revert rm"

FIC_NAME=$(basename "$1")
FIC_PATH=$(dirname "$1")

if [ ! -d $FIC_PATH/.version ] || [ ! -f $FIC_PATH/.version/$FIC_NAME.1 ];then
	echo "The file '"$FIC_NAME"' is not under versioning, please use add."
	echo $USAGE
	exit 2
fi

NB_VERSION=0

for VAR in $FIC_PATH/.version/$FIC_NAME.*;do
	NB_VERSION=$(($NB_VERSION+1))
done

NEW_VERSION=$(diff $1 $FIC_PATH/.version/$FIC_NAME.latest)

if [ -z "$NEW_VERSION" ];then
	echo "The latest version is the same as "$FIC_NAME""
	exit 3
fi

diff "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest > "$FIC_PATH"/.version/"$FIC_NAME"."$NB_VERSION"
cp "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest

echo "Committed a new version: $NB_VERSION"


