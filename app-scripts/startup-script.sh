#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemcl start httpd
sudo systemcl stop firewalld
sudo systemcl disable firewalld
sudo chmod -R 777 /var/www/html
sudo echo "Welcome to your web server - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo mkdir /var/www/html/app1
sudo echo "Welcome to your web server - VM Hostname: $(hostname)" > /var/www/html/app1/hostname.html
sudo echo "Welcome to your web server Status Page" > /var/www/html/app1/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to your newly built VM </h1> <p>Tearraform Demo</p> <p>Application Version: V1 </p> </body></html>' | sudo tee /var/wwww/html/app1/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01 -o /var/www/html/app1/metadata.html