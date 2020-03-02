#!/bin/bash

if [[ ! "$USER" = "root" ]]; then
	echo "You need to login as 'root' user before you can add a new site."
	return
fi

if [[ ! "$DOMAIN" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN
fi

if [[ ! "$PUBLIC_DIR" ]]; then
	echo "What do you want the site's public directory to be? [public]"
	read -r PUBLIC_DIR
fi

{
	echo "server {"
	echo "  listen 80;"
	echo "  listen [::]:80;"
	echo ""
	echo "  root /var/www/$DOMAIN/live/$PUBLIC_DIR;"
	echo "  index index.html index.htm index.nginx-debian.html;"
	echo ""
	echo "  server_name $DOMAIN www.$DOMAIN;"
	echo ""
	echo "  location / {"
	echo "    try_files \$uri \$uri/ =404;"
	echo "  }"
	echo "}"
} >>"/etc/nginx/sites-available/$DOMAIN"
