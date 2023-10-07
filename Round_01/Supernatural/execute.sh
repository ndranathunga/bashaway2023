mkdir -p /shared_data

docker run --name=seraphina -d -v /shared_data:/twilight alpine:3.14 sleep infinity

docker exec seraphina /bin/sh -c "echo \"$(cat /proc/sys/kernel/random/uuid)\" >> /home/potions.txt"

# Write your code here

# Define the container name or ID
CONTAINER_NAME_OR_ID="seraphina"

# Define the directory path you want to create
DIRECTORY_PATH="/twilight"

# Run the command inside the container to create the directory and exit immediately
docker exec "$CONTAINER_NAME_OR_ID" mkdir -p "$DIRECTORY_PATH"

docker commit seraphina isabella

docker run -d --name isabella -v /shared_data:/twilight isabella

