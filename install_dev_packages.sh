#!/bin/sh

# Ensure pipx is using the local bin directory
export PATH="$HOME/.local/bin:$PATH"

# Read each line in requirements-dev.txt
while read requirement; do
    pipx install "$requirement"
done <requirements-dev.txt
