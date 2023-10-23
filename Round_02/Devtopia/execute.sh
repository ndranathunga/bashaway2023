
#!/bin/bash

# Step 1: Clone the Repository (assuming Git is installed)
git clone https://github.com/Akalanka47000/pharmaceutical.git pharmaceutical-mainx

# Step 2: Navigate to the directory and extract environment keys
cd pharmaceutical-mainx
python3 - <<END

import os

# Define services and their expected directories
services = [
    'orchestrator', 
    'auth-service', 
    'user-service', 
    'email-service', 
    'product-service', 
    'sms-service'
]

# Define the root directory of the cloned repository
root_dir = 'pharmaceutical-mainx'

# Extract environment keys from .env.example files for each service
env_keys = {}
for service in services:
    service_dir_name = service.replace('-service', '')
    env_example_path = os.path.join(root_dir, 'services', service_dir_name, '.env.example')
    if os.path.exists(env_example_path):
        with open(env_example_path, 'r') as file:
            env_keys[service] = file.read()

# Print the extracted environment keys
for service, keys in env_keys.items():
    print(f'# Environment variables for {service}')
    print(keys)
    print()

END

cd ..
rm -rf pharmaceutical-mainx

# Step 3: Set up services using docker-compose
docker network create bashaway-2k23 || true  # Creates the network, or does nothing if it already exists
docker-compose -f /path/to/docker-compose-updated.yml up -d 

