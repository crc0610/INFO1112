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

if [ "$files" == "" ]; then
    echo -e "No. of modified log files: 0\n"
    exit 0
else
    total_count=0
    largest_count=0
    largest_log=""

    for file in $files
    do 
        count=$(grep -i "error" "$file" | wc -l)
        total_count=$((total_count + count))
        
        if [ $count -gt $largest_count ]; then
            largest_count=$count
            largest_log=$(echo "$file <error-count:$count>")
        fi

        echo "$file <No. of errors found = $count>"
        echo "$file <No. of errors found = $count>" >> ~/analysisData.log

    done

    echo "Total errors found:$total_count"
    echo "File with the max errors:$largest_log"

    echo "Total errors found:$total_count" >> ~/summary.log
    echo "File with the max errors:$largest_log" >> ~/summary.log

fi
