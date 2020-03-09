#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

export BIN=${0:a:h}

# ##################

# Get Domain
if [[ -z "$1" ]]; then
	echo "What site do you want to remove? [example.com]"
	read -r OLD_NAME
else
	OLD_NAME="$1"
fi

if [[ -z "$2" ]]; then
	echo "What site do you want to remove? [example.com]"
	read -r NEW_NAME
else
	NEW_NAME="$2"
fi

# Filenames
OLD_FNAME="${OLD_NAME//./_}"
NEW_FNAME="${NEW_NAME//./_}"

# ##################

# project_d="/var/www/$DOMAIN"
# scripts_f="SCRIPTS_PATH/$FNAME.sh"
# hook_f="HOOKS_PATH/$FNAME.json"
# info_f="INFO_PATH/$FNAME"
# nginx_enabled_f="/etc/nginx/sites-enabled/$DOMAIN"
# nginx_available_f="/etc/nginx/sites-available/$DOMAIN"
# ssl_d="/etc/letsencrypt/live/$DOMAIN"

# ##################

# Use 'sed' to replace site names in files and use mv to replace file names
# hooks
# scripts
# info
# project

# #####################################

unset OLD_NAME NEW_NAME OLD_FNAME NEW_FNAME

# sudo sed -i -e "s/# server_names_hash_bucket_size/server_names_hash_bucket_size/" "/etc/nginx/nginx.conf"
