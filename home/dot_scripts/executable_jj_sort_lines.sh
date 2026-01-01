#!/usr/bin/env bash
set -e

# Create a temporary file
tmpfile=$(mktemp)

# Ensure the temp file is cleaned up on exit
trap 'rm -f "$tmpfile"' EXIT

# Read stdin and store into temp file
cat >"$tmpfile"

sort-lines "$tmpfile"

cat "$tmpfile"
