#!/bin/bash

# Define the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Add the script's directory to the PATH for this session
export PATH="$PATH:$SCRIPT_DIR"

# Define the function ethereal
ethereal() {
    # Check if etherealbinarybeast command exists
    if command -v etherealbinarybeast &> /dev/null; then
        # Invoke etherealbinarybeast command if it exists
        etherealbinarybeast "$@"
    else
        echo "The etherealbinarybeast command has not been established yet."
        echo "You must complete your quest to establish it."
    fi
}

# Check if the script is being invoked with arguments
if [ "$#" -gt 0 ]; then
    # If arguments are provided, invoke the ethereal function with them
    ethereal "$@"
else
    # If no arguments are provided, just invoke the ethereal function
    ethereal
fi
