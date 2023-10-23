
#!/bin/bash

# Check if a correlation id is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "No correlation id provided."
fi

# Define the correlation id
correlation_id="$1"

# Search for the correlation id within the log files in the src directory without including the filename in the output
grep -h -r "$correlation_id" src/
