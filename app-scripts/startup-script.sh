#!/bin/sh
sudo apt update
sudo apt install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2
sudo ufw disable
sudo chmod -R 777 /var/www/html
sudo echo "Welcome to your web server - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to your web server - VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/app1/metadata.html