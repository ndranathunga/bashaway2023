#!/bin/bash

# Install Node.js and npm if not already installed
if ! command -v node &> /dev/null; then
  echo "Node.js is not installed. Installing..."
  curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

# Install http-server package
npm install -g http-server

# Create a directory for your HTML page
mkdir -p ~/webcraft
cd ~/webcraft

# Use the cat command to read the contents of my_page.html
# and then redirect the contents into index.html
cat my_page.html > index.html

# Function to start the http-server and wait until it's ready
start_http_server() {
  http-server -p 8085 &
  local pid=$!
  sleep 2 # Give it some time to start
  while ! curl -s http://localhost:8085 > /dev/null; do
    sleep 2
  done
  echo "Web server is ready (PID: $pid)"
}

# Start the http-server and wait for it to be ready
start_http_server &

# Continue with other tasks or tests
