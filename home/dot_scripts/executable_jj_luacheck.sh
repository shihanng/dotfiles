#!/usr/bin/env bash
set -e

# Read stdin into a variable
input=$(cat)

# Pass the input to luacheck with all arguments and check exit code
if echo "$input" | luacheck "$@" -; then
    echo "$input"
fi
