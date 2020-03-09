#!/bin/bash
# shellcheck disable=SC1090,SC2034
#
# Makes sure the domain doesn't already exist
# so that it can be created
# #####################################

export BIN=${0:a:h}

# Get Info
if [[ -z "$1" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN
else
	DOMAIN="$1"
fi

# Replace '.' with '_' to use for file names
export FNAME="${DOMAIN//./_}"

project_d="/var/www/$DOMAIN"
scripts_f="SCRIPTS_PATH/$FNAME.sh"
hook_f="HOOKS_PATH/$FNAME.json"
info_f="INFO_PATH/$FNAME"
nginx_enabled_f="/etc/nginx/sites-enabled/$DOMAIN"
nginx_available_f="/etc/nginx/sites-available/$DOMAIN"
ssl_d="/etc/letsencrypt/live/$DOMAIN"

# ##################

if [[ -d "$project_d" || -f "$scripts_f" || -f "$hook_f" || -f "$info_f" || -f "$nginx_available_f" || -f "$nginx_enabled_f" || -d "$ssl_d" ]]; then
	echo "There seems to be some files associated with $DOMAIN."
	echo "This could cause problems"
	echo "Try running [ sites list ] to see all the sites."
	return
fi

# ##################

unset project_d scripts_f hook_f info_f nginx_enabled_f nginx_available_f ssl_d
