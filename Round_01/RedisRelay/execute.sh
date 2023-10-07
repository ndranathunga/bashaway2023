#!/bin/bash

# Redis credentials
REDIS_HOST="localhost"
REDIS_PORT="6380"
REDIS_USERNAME="default"
REDIS_PASSWORD="5ax4*1\$2"

# Function to generate a random string
generate_random_string() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $1 | head -n 1
}

# Connect to Redis and inject keys
for ((i=1; i<=500; i++)); do
  key=$(generate_random_string 10)
  value=$(generate_random_string 20)
  redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" -u "$REDIS_USERNAME" -a "$REDIS_PASSWORD" SET "$key" "$value"
done

# Set the special key 'bashaway-2k23' with the current timestamp in epoch format (milliseconds)
current_timestamp=$(date +%s%3N)
redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" -u "$REDIS_USERNAME" -a "$REDIS_PASSWORD" SET "bashaway-2k23" "$current_timestamp"
