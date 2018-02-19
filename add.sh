#!/bin/dash


if test ! -f "$1";then
    echo "Error : file $1 does not exist"
    exit 1
fi