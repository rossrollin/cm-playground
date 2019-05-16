#!/bin/bash
# Shellscript to configure the load balancer. 
echo "Configuring load balancer"
sudo apt-get update
sudo apt-get install -y nginx
sudo service nginx stop
sudo rm -rf /etc/nginx/sites-enabled/default
sudo touch /etc/nginx/sites-enabled/default
echo "upstream website {
        server 172.0.0.10;
        server 172.0.0.20;
}
server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;
        root /usr/share/nginx/html;
        index index.html index.htm;
        server_name localhost;
        location / {
                proxy_pass http://website;
        }
}" >> /etc/nginx/sites-enabled/default
echo 'Load balancer provisioned'