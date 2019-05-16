#!/bin/sh
# Shellscript to configure the web instances using shell provisioner.
echo "Provisioning Web Server $1"
sudo apt-get update
sudo apt-get install -y nginx
touch /usr/share/nginx/html/index.html
# This is the Hello World index.html deployment
cat << EOF >/usr/share/nginx/html/index.html
<html>
<h1> Hello World! </h1>
<body> This is Webserver $1</body>
</html>
EOF
sudo rm -rf /etc/nginx/sites-enabled/default
sudo touch /etc/nginx/sites-enabled/default
echo "server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;
        root /usr/share/nginx/html;
        index index.html index.htm;
        server_name localhost;
}" >> /etc/nginx/sites-enabled/default
sudo service nginx restart