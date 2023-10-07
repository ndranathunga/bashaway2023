#!/bin/bash
pnpm i -g pm2

pm2 delete network-sorcery

pm2 start src/server.js --name network-sorcery -f

# Write your code here
#!/bin/bash

# Update the hosts file to route the domain to localhost with sudo
sudo sh -c 'echo "127.0.0.1 api.jokes.bashaway.sliitfoss.org" >> /etc/hosts'

# Install required packages
sudo apt-get update
sudo apt-get install -y socat

# Define the source and destination ports
src_port=443
dst_port=3000

# Clear existing iptables rules
iptables -t nat -F

# Redirect traffic from 443 to 3000
iptables -t nat -A PREROUTING -p tcp --dport $src_port -j REDIRECT --to-port $dst_port

# Start your Node.js server using PM2
pnpm i -g pm2
pm2 delete network-sorcery
pm2 start src/server.js --name network-sorcery -f

# Create a socat tunnel to handle the redirection
socat TCP4-LISTEN:$src_port,fork TCP4:localhost:$dst_port
