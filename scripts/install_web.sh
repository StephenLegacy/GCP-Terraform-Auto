#!/bin/bash
# Update the system
sudo apt-get update -y

# Install Apache
sudo apt-get install -y apache2

# Start and enable Apache service
sudo systemctl start apache2
sudo systemctl enable apache2

# Create a simple HTML page
echo "<h1>Welcome DEVFEST KISII WEB Server</h1>" > /var/www/html/index.html
