#!/bin/bash

# Create a temporary directory
temp_dir=$(mktemp -d)

# Copy the Pascal-like script from the src directory to the temporary directory
cp src/markings.pas "$temp_dir/markings.pas"

# Navigate to the temporary directory
cd "$temp_dir"

# Execute the Pascal script using the Free Pascal Compiler (fpc)
# Redirect the output to a temporary file for later use
fpc markings.pas > output.txt 2>&1

# Check if the compilation was successful
if [ $? -eq 0 ]; then
    # If successful, run the compiled program and print its output to the console
    ./markings
fi

# Clean up the temporary directory
cd -
rm -rf "$temp_dir"
