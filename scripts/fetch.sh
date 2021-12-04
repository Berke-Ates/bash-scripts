#!/bin/bash
cd $(dirname $0)/../..

if ! prog.sh "git fetch -p" "fetching remote branches" "fetched!\n" "fetching failed!\n"; then
    exit 1
fi

branches=$(git branch | grep -v "main")
if ! prog.sh "git branch -D $branches" "deleting local branches" "deleted!\n" "deletion failed!\n"; then
    exit 1
fi
