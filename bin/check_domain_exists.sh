#!/bin/bash
# shellcheck disable=SC1090,SC2034
#
# Makes sure the domain doesn't already exist
# so that it can be created
# #####################################

# export BIN=${0:a:h}

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

site_exists=false
project_exists=false
script_exists=false
hook_exists=false
info_exists=false
nginx_available_exists=false
nginx_enabled_exists=false
ssl_exists=false

# ##################

if [[ -d "$project_d" ]]; then
	site_exists=true
	project_exists=true
fi

if [[ -f "$scripts_f" ]]; then
	site_exists=true
	script_exists=true
fi

if [[ -f "$hook_f" ]]; then
	site_exists=true
	hook_exists=true
fi

if [[ -f "$info_f" ]]; then
	site_exists=true
	info_exists=true
fi

if [[ -f "$nginx_available_f" ]]; then
	site_exists=true
	nginx_available_exists=true
fi

if [[ -f "$nginx_enabled_f" ]]; then
	site_exists=true
	nginx_enabled_exists=true
fi

if [[ -d "$ssl_d" ]]; then
	site_exists=true
	ssl_exists=true
fi

# ##################

unset project_d scripts_f hook_f info_f nginx_enabled_f nginx_available_f ssl_d
