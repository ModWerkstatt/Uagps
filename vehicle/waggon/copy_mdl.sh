#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Find all .mdl files recursively and copy them to the script directory
find . -type f -name "*.mdl" -exec mv {} "$SCRIPT_DIR/" \;

echo "Done! All .mdl files have been copied to $SCRIPT_DIR"
