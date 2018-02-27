#!/bin/dash

add(){
    mkdir "$FIC_PATH"/.version 2> /dev/null

    if test -f "$FIC_PATH/.version/$FIC_NAME.1"; then
        echo "Error: File named '$FIC_NAME' has already been added" >&2
        exit 4
    fi

    #Creation of 2 files: the in itiale and the latest
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
};

checkout(){
    if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".1 ];then
        echo "Error : the file '$FIC_NAME' is not under versioning, please use add." >&2
        echo "$USAGE" >&2
        exit 3
    fi

    #We test if $2 is a number, We compare $2 with a number and we test the return code.
    test "$2" -lt 0 2> /dev/null
    if test $? -gt 1 ;then
        echo "Error : the argument must be a number" >&2
        echo "$USAGE" >&2
        exit 6
    fi 

    if test "$2" -lt 0;then
        echo "Error : the argument must be greater than 0" >&2
        echo "$USAGE" >&2
        exit 6
    fi

    if test ! -f "$FIC_PATH"/.version/"$FIC_NAME"."$2";then
        echo "Error : this version doesn't exist" >&2
        echo "Use log to learn about the existing version" >&2
        echo "$USAGE" >&2
        exit 7
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
};

commit(){


    if [ ! -f "$1" ];then
        echo "Error: The file $1 does not exist"
        exit 2
    fi

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
        exit 8
    fi

    diff "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest > "$FIC_PATH"/.version/"$FIC_NAME"."$NB_VERSION"
    cp "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest
    echo "$(date -R)" "$2" >> "$FIC_PATH"/.version/"$FIC_NAME".log


    echo "Committed a new version: $NB_VERSION"
    exit 0
};

diff1(){
    USAGE2="Usage: version.sh diff file"

    if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".1 ];then
        echo "Error: The file '$FIC_NAME' is not under versioning, please use add." >&2
        echo "$USAGE2" >&2
        exit 3
    fi

    diff -u "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest

    if test $? -eq 0;then
        echo "No difference found"
    fi

    exit 0
};

log(){
    USAGE3="Usage: version.sh log file"

    if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".log ];then
        echo "Error: The file '$FIC_NAME' is not under versioning, please use add." >&2
        echo "$USAGE3" >&2
        exit 3
    fi

    nl "$FIC_PATH"/.version/"$FIC_NAME".log | sed 's/\([0-9]\)/\1:/'
    exit 0
};

revert(){

    USAGE4="Usage: version.sh revert file"

    #check if the file has already been versioned
    if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".latest ];then
        echo "Error: The file '$FIC_NAME' is not under versioning, impossible to revert." >&2
        echo "$USAGE4" >&2
        exit 3
    fi

    DIFF=$(diff "$1" "$FIC_PATH"/.version/"$FIC_NAME".latest)

    if [ -z "$DIFF" ];then
        echo "The latest version is the same as $FIC_NAME"
        exit 5
    fi

    #We write in the file the content of the .latest
    cp "$FIC_PATH"/.version/"$FIC_NAME".latest "$1"
    echo "Reverted to the latest version"
    exit 0
};

rm1(){
    if [ ! -d "$FIC_PATH"/.version ] || [ ! -f "$FIC_PATH"/.version/"$FIC_NAME".1 ];then
        echo "Error: The file '$FIC_NAME' is not under versioning, please use add." >&2
        echo "$USAGE" >&2
        exit 3
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
        for FIC in "$FIC_PATH"/.version/"$FIC_NAME"*;do
            rm "$FIC"
            rmdir "$FIC_PATH"/.version 2> /dev/null
        done
        echo "'$FIC_NAME' is not under versioning anymore."
        exit 0
    fi

    exit 0
};


USAGE="Usage: version.sh <command> file [option]\nWhere <command> can be: add checkout commit diff log revert rm"
FIC_NAME=$(basename "$2")
FIC_PATH=$(dirname "$2")

if [ $# -lt 2 ]; then
    echo "Error: wrong number of arguments" >&2
    echo "$USAGE" >&2
    exit 1
fi

if test ! -f "$2";then
    echo "Error: file '$FIC_NAME' does not exist" >&2
    exit 2
fi

case "$1" in
    ( "add" )
    	add "$2" "$3";;
    ( "rm" )
        rm1 ;;
    ( "commit" )
        commit "$2" "$3";;
    ( "ci" )
        commit "$2" "$3";;
    ( "revert" )
        revert "$2";;
    ( "diff" )
        diff1 "$2";;
    ( "checkout" )
        checkout "$2" "$3";;
    ( "co" )
        checkout "$2" "$3";;
    ( "log" )
        log "$2";;
    ( * )
        echo "Error: this command name does not exist : $1" >&2
        echo "$USAGE" >&2
        exit 6;;
esac

exit 0

