#!/bin/bash

# TODO
if [ $# -eq 0 ]; then
    dir=$(pwd)

elif [ $# -eq 1 ]; then
    if [ ! -d "$1" ]; then
        echo -e "usage: arg needs to be a directory.\n"
        exit 1

    else
        dir=$1
    fi

else
    echo -e "usage: more than 1 arg is not allowed.\n"
    exit 2
fi

files=$(find "$dir" -mindepth 1 -maxdepth 1 -name "*log" -mtime -7 ! -name "analysisData.log" ! -name "summary.log")
> ~/analysisData.log
> ~/summary.log
