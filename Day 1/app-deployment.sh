#!/bin/bash

# Update and upgrade packages
sudo apt update -y && sudo apt upgrade -y

# Install git
sudo apt install git -y

# Install NGINX
sudo apt install -y nginx

# Configure NGINX as reverse proxy
sudo sed -i 's/try_files $uri $uri\/ =404;/proxy_pass http:\/\/localhost:3000\/;/g' /etc/nginx/sites-available/default

# Restart and enable NGINX
sudo systemctl restart nginx
sudo systemctl enable nginx

# Install Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Clone or update the repo
git clone https://github.com/Giubis/nodejs20-se-test-app-2025.git

# Enter the app directory
cd nodejs20-se-test-app-2025/app

# Install Node dependencies
npm install

# Install pm2 globally
sudo npm install -g pm2@latest

# Stop previous processes
pm2 kill

# Start the app with pm2
pm2 start app.js --watch