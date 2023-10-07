#!/bin/bash
total_bytes=0

for file in src/*; do
  if [ -f "$file" ]; then
    file_size=$(stat -c %s "$file")
    total_bytes=$((total_bytes + file_size))
  fi
done

echo "$total_bytes"
