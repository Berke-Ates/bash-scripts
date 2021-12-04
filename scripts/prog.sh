#!/bin/bash

# Desc: Displays a spinner for a running. Upon completion shows tick or cross
# Usage: prog.sh <Command> <Running text> <Success text> <Failure text> 
# Flags: 
#           -v Verbose: Prints the output of the command
#           -r Reverse: Interprets non-zero exit code as success
# Exit code: Matches exit code of command unless -r is set
# Example: ./prog.sh "git fetch -p" "fetching" "fetched!\n" "fetching failed\n"

spinner() {
    local i sp n
    sp='/-\|'
    n=${#sp}
    while sleep 0.1; do
        echo -ne "\r${sp:i++%n:1} $1 "
    done
}

hasFlag(){
    local term="$1"
    shift
    for arg; do
        if [[ $arg == "$term" ]]; then
            return 0
        fi
    done
    return 1
}

spinner "$2" &
spinner_pid=$!

$($1 &> /dev/null)
succ=$? # save exit code of previous command

kill $spinner_pid &>/dev/null
echo -ne "\r\e[K" # clear line (-e enables backslash interpretation)

if hasFlag '-r' "$@"; then
    if [ $succ -ne 0 ]; then
        echo -ne "\u2705 $4" # \u274c prints a checkmark
        exit 0
    fi

    if hasFlag '-v' "$@"; then
        echo -e "$($1)" # In quotation marks so new lines get printed
    fi
    echo -ne "\u274c $3" # \u2714 prints a cross
    exit 1
fi

if [ $succ -ne 0 ]; then
    if hasFlag '-v' "$@"; then
        echo -e "$($1)" # In quotation marks so new lines get printed
    fi

    echo -ne "\u274c $4" # \u274c prints a cross
    exit 1
fi

echo -ne "\u2705 $3" # \u2714 prints a checkmark
exit 0
