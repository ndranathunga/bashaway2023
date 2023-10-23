
#!/bin/bash

# Ensure the script exits if any command fails
set -e

# Define the src and out directories
SRC_DIR="src"
OUT_DIR="out"

# Create the out directory if it doesn't exist
mkdir -p $OUT_DIR

# Check if the src directory exists
if [ -d "$SRC_DIR" ]; then
  # Iterate through each shell script in the src directory
  for SCRIPT in $SRC_DIR/*.sh; do
    # Only proceed if the file exists (to handle cases where no .sh files are present)
    if [ -f "$SCRIPT" ]; then
      # Extract the base name of the script without the extension for packaging
      BASE_NAME=$(basename "$SCRIPT" .sh)
      TEMP_DIR="temp_$BASE_NAME"
      
      # Create a temporary directory for packaging
      mkdir -p $TEMP_DIR
      
      # Copy the script to the temporary directory
      cp $SCRIPT $TEMP_DIR
      
      # Create a package.json in the temporary directory
      echo '{
        "name": "'$BASE_NAME'",
        "version": "1.0.0",
        "bin": "'$BASE_NAME'.sh"
      }' > $TEMP_DIR/package.json
      
      # Navigate to the temporary directory
      pushd $TEMP_DIR
      
      # Pack the directory into a tarball
      npm pack
      
      # Move the tarball to the out directory and rename it
      mv $BASE_NAME-*.tgz ../$OUT_DIR/$BASE_NAME.tgz
      
      # Navigate back to the original directory
      popd
      
      # Remove the temporary directory
      rm -rf $TEMP_DIR
    fi
  done
fi
