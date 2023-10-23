# Start Install Google Chrome (You may comment out these lines during local testing if you already have Chrome installed)

sudo apt update

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

sudo apt-get install -f

rm google-chrome-stable_current_amd64.deb

# End Install Google Chrome

# Write your code here
# Install nginx
sudo apt update
sudo apt install -y nginx

# Configure nginx
cat > /etc/nginx/sites-available/merged-projects <<EOF
server {
    listen 8088;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /dashboard {
        proxy_pass http://localhost:8081;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /support {
        proxy_pass http://localhost:8082;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
EOF

# Create a symlink to enable our configuration
sudo ln -s /etc/nginx/sites-available/merged-projects /etc/nginx/sites-enabled/

# Remove the default configuration
sudo rm /etc/nginx/sites-enabled/default

# Placeholder to start all projects
# TODO: You will need to replace the following lines with the actual commands to start each project
# start_cornerstone_project &
# start_dashboard_project &
# start_support_system_project &

# Restart nginx to apply configurations
sudo service nginx restart
