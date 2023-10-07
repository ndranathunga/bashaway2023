#!/bin/bash

# Start Azure Storage Emulator on port 12000
azurite -l 0.0.0.0 -d /path/to/data-directory -s -p 12000 &

# Wait for a few seconds to ensure the emulator is up and running
sleep 5

# Blob service URL for the emulator
BLOB_SERVICE_URL="http://localhost:12000/devstoreaccount1"

# Container name
CONTAINER_NAME="bashaway"

# Blob name
BLOB_NAME="example.txt"

# Blob content
BLOB_CONTENT="This is an example blob content."

# Create a blob
azcopy copy "$BLOB_CONTENT" "$BLOB_SERVICE_URL/$CONTAINER_NAME/$BLOB_NAME"

# Download a blob
azcopy copy "$BLOB_SERVICE_URL/$CONTAINER_NAME/$BLOB_NAME" ./downloaded_blob.txt

# Display the downloaded content
cat ./downloaded_blob.txt

# Delete a blob
azcopy rm "$BLOB_SERVICE_URL/$CONTAINER_NAME/$BLOB_NAME"

# Stop Azure Storage Emulator when done
pkill -f "azurite"
