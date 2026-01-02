#!/usr/bin/env bash

# Read stdin into a variable
input=$(cat)

# Redirect tflint output to stderr so that jj fix can capture it.
tflint "$@" >&2
exit_code=$?

# Output the input only if tflint succeeded
if [ $exit_code -eq 0 ]; then
    echo "$input"
fi

exit $exit_code
