#!/bin/bash

# Desc: Deletes all ':Zone.Identifier' files
# Usage: clean_zone.sh
# Example: ./clean_zone.sh

for filename in $(find * -name '*:Zone.Identifier'); do
    rm $filename
done
