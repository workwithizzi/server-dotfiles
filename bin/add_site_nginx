#!/bin/bash

# #####################################

# Get Info
if [[ ! "$USER" = "root" ]]; then
	echo "You need to login as 'root' user before you can add a new site."
	return
fi

if [[ ! "$DOMAIN" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN

	# If $DOMAIN is defined, then these will be too:
	echo "What do you want the site's public directory to be? [Default = $ENV_PUBLIC_DIR]"
	read -r PUBLIC_DIR
	if [[ ! "$PUBLIC_DIR" ]]; then
		PUBLIC_DIR="$ENV_PUBLIC_DIR"
	fi

	echo "Associated username? [Default = $ENV_SITE_OWNER"
	read -r OWNER
	if [[ ! "$OWNER" ]]; then
		OWNER="$ENV_SITE_OWNER"
	fi

fi

# #####################################

# Create and add configuration
sudo touch "/etc/nginx/sites-available/$DOMAIN"

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

assign_file "$OWNER" "/etc/nginx/sites-available/$DOMAIN"

# enable the site with NGINX
sudo ln -s "/etc/nginx/sites-available/$DOMAIN" "/etc/nginx/sites-enabled/"

# Reload NGINX
_nginx reload
