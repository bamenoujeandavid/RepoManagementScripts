#!/bin/bash

badFiles=$(find -H $1 -type f -iname "*.sh" -or -iname "~*" -or -iname "*#" -or -iname ".*")

isCheckedFile() {

    while read line
    do
    a=$(echo $line)
        if [ "$a" = "${1:2}" ]; then
        return 1
        fi
    done < File
    return 0
}

for file in $badFiles
do
    isCheckedFile $file
    if [ "$?" -eq 0 ]; then
    echo "$file" >> File
    fi
done
