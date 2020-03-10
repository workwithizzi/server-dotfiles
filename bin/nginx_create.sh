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
[[ -f "$HOME/.defaults" ]] && source "$HOME/.defaults"

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

# Make sure to reload NGINX after creation
