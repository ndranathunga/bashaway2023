#!/bin/bash

# Define the source and output directories
src_dir="src"
out_dir="out"
output_file="merged-scrolls.csv"

# Create the output directory if it doesn't exist
mkdir -p "$out_dir"

# Initialize an empty temporary file
temp_file="$out_dir/temp.csv"
touch "$temp_file"

# Iterate over the CSV files in the source directory
for file in "$src_dir"/*.csv; do
    # Check if the file exists and is not empty
    if [ -s "$file" ]; then
        # Extract the values (Gold Drakes) and convert them to Silver Sovereigns
        awk -F',' -v OFS=',' 'NR>1 { printf("%s,%.2f\n", $1, $2 * 178) }' "$file" >> "$temp_file"
    fi
done

# Sort the values in descending order based on the converted Silver Sovereigns
sort -t',' -k2,2nr -o "$temp_file" "$temp_file"

# Add a header row with the currency in Silver Sovereigns
echo "Item,Value(Silver Sovereigns)" > "$out_dir/$output_file"

# Concatenate the header and sorted values and save to the output file
cat "$temp_file" >> "$out_dir/$output_file"

# Clean up the temporary file
rm "$temp_file"

echo "Merged and converted scrolls saved to $out_dir/$output_file"
