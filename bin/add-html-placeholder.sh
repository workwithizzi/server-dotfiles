#!/bin/bash

if [[ ! "$DOMAIN" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN
fi

if [[ ! "$PUBLIC_DIR" ]]; then
	echo "What do you want the site's public directory to be? [public]"
	read -r PUBLIC_DIR
fi

if [[ ! -d "/var/www/$DOMAIN/live/$PUBLIC_DIR" ]]; then
	sudo mkdir -p "/var/www/$DOMAIN/live/$PUBLIC_DIR"
fi

{
	echo "<html>"
	echo "  <head>"
	echo "    <title>Welcome to $DOMAIN!</title>"
	echo "  </head>"
	echo "  <body>"
	echo "    <h1>Success!  The $DOMAIN server block is working!</h1>"
	echo "  </body>"
	echo "</html>"
} >>"/var/www/$DOMAIN/live/$PUBLIC_DIR/index.html"
