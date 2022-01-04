#!/bin/bash

# Desc: Prints the lines for all files
# Usage: check_file_length.sh <directory> <list of file extensions>
# Example: ./check_file_lengthsh . cpp c h dart go

for ext in ${@:2}; do 
    echo "Searching for $ext files"
    for f in $(find $1 -name "*.$ext"); do
        lc=$(wc -l $f)
        echo "$lc"
    done
done
