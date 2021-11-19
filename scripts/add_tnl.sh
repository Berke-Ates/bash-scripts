#/bin/bash

# Desc: Adds trailing new line to all files in directory filtered by extension
# Usage: add_tnl.sh <directory> <list of file extensions>
# Example: ./add_tnl.sh . dart xml plist md storyboard html

for ext in ${@:2}; do 
    echo "Searching for $ext files"
    for f in $(find $1 -name "*.$ext"); do 
        if [ -s "$f" ] && [ "$(tail -c1 "$f"; echo x)" != $'\nx' ]; then
            echo "" >> "$f"
            echo -e "  \u2705 fixed $f"
        fi
    done
done
