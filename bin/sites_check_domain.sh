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

project="/var/www/$DOMAIN"
script="SCRIPTS_PATH/$FNAME.sh"
hook="HOOKS_PATH/$FNAME.json"
info="INFO_PATH/$FNAME"
nginx_enabled="/etc/nginx/sites-enabled/$DOMAIN"
nginx_available="/etc/nginx/sites-available/$DOMAIN"

if [[ -d "$project" || -f "$script" || -f "$hook" || -f "$info" || -f "$nginx_available" || -f "$nginx_enabled" ]]; then
	echo "There seems to be some files associated with $DOMAIN."
	echo "This could cause problems"
	echo "Try running [ sites list ] to see all the sites."
	return
fi
