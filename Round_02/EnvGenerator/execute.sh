#!/bin/bash

# Create the output directory if it doesn't exist
mkdir -p out

# Parse the YAML file to extract secret names and corresponding file names
while IFS=":" read -r key value; do
  if [[ "$key" =~ ^\ *name\ *$ ]]; then
    secret_name="$(echo "$value" | tr -d ' ')"
    file_name=".env.${secret_name}"
    echo "Creating $file_name from secret $secret_name"
    
    # Extract the secret data and decode it
    secret_data=$(kubectl get secret "$secret_name" -o jsonpath='{.data}' | base64 --decode)
    
    # Write the secret data to the .env file
    echo "$secret_data" > "out/$file_name"
  fi
done < <(kubectl get secret -o yaml)

echo "Generated .env files are stored in the 'out' directory."
