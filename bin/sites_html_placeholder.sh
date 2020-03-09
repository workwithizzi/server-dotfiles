#!/bin/bash
# shellcheck disable=SC1090,SC2034
#
# Args
# - 1: domain
# - 2: owner
# - 3: public directory
# #####################################

export BIN=${0:a:h}

# Get Defaults
[[ -f "$HOME/.env" ]] && source "$HOME/.env"

# Make scripts dir
if [[ ! -d "$SCRIPTS_PATH" ]]; then
	sudo mkdir -p "$SCRIPTS_PATH"
fi

# ##################
# Get Domain
if [[ -z "$1" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN
else
	DOMAIN="$1"
fi
# Filename
FNAME="${DOMAIN//./_}"

# Make sure the site doesn't already exist
source "$BIN/check_domain_exists.sh" "$DOMAIN"

# ##################
# Get Owner
if [[ -z "$2" ]]; then
	echo "Associated username? [Default = $ENV_SITE_OWNER]"
	read -r OWNER
else
	OWNER="$2"
fi
if [[ -z "$OWNER" ]]; then
	OWNER="$ENV_SITE_OWNER"
fi

# ##################
# Get Public Directory
if [[ -z "$3" ]]; then
	echo "What do you want the site's public directory to be? [Default = $ENV_PUBLIC_DIR]"
	read -r PUBLIC_DIR
else
	PUBLIC_DIR="$3"
fi
if [[ -z "$PUBLIC_DIR" ]]; then
	PUBLIC_DIR="$ENV_PUBLIC_DIR"
fi

# #####################################

# Create public directory
if [[ ! -d "/var/www/$DOMAIN/live/$PUBLIC_DIR" ]]; then
	sudo mkdir -p "/var/www/$DOMAIN/live/$PUBLIC_DIR"
fi

sudo touch "/var/www/$DOMAIN/live/$PUBLIC_DIR/index.html"

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

assign_file "$OWNER" "/var/www/$DOMAIN/live/$PUBLIC_DIR/index.html"
