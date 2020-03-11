#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

export BIN=${0:a:h}

# ##################
# Get Domain
if [[ -z "$1" ]]; then
	echo "What site do you want to remove? [example.com]"
	read -r DOMAIN
else
	DOMAIN="$1"
fi
# Filename
FNAME="${DOMAIN//./_}"

# ##################
# TODO: Add test to make sure site exists before going through them
# TODO: Add option to archive instead of delete

# TODO: Remove works, but prints error message even when there's no error

# ##################
project_d="/var/www/$DOMAIN"
scripts_f="$SCRIPTS_PATH/$FNAME.sh"
hook_f="$HOOKS_PATH/$FNAME.json"
info_f="$INFO_PATH/$FNAME"
nginx_enabled_f="/etc/nginx/sites-enabled/$DOMAIN"
nginx_available_f="/etc/nginx/sites-available/$DOMAIN"
ssl_d="/etc/letsencrypt/live/$DOMAIN"

# ##################
# Nginx
if [[ -f "$nginx_enabled_f" ]]; then
	rm "$nginx_enabled_f"
fi
if [[ -f "$nginx_available_f" ]]; then
	rm "$nginx_available_f"
	echo "NGINX was removed."
	files_removed=true
fi

# ##################
# Project Files
if [[ -d "$project_d" ]]; then
	rm -rf "$project_d"
	echo "Project files where removed."
	files_removed=true
	files_removed=true
fi

# ##################
# Depoloy Scripts
if [[ -f "$scripts_f" ]]; then
	rm "$scripts_f"
	echo "Deploy script was removed."
	files_removed=true
fi

# ##################
# Depoloy Scripts
if [[ -f "$scripts_f" ]]; then
	rm "$scripts_f"
	echo "Deploy script was removed."
	files_removed=true
fi

# ##################
# Webhook
if [[ -f "$hook_f" ]]; then
	rm "$hook_f"
	echo "Webhook was removed."
	files_removed=true
fi

# ##################
# Info
if [[ -f "$info_f" ]]; then
	rm "$info_f"
	echo "Info file was removed."
	files_removed=true
fi

# ##################
# SSL Cert
if [[ -d "$ssl_d" ]]; then
	sudo certbot delete --cert-name "$DOMAIN"
	echo "SSL cert was removed."
	files_removed=true
fi

# ##################

if [[ -z "$files_removed" ]]; then
	echo "All files related to $DOMAIN have been removed."
else
	echo "There were no files related to $DOMAIN to remove."
	echo "To see a list of all sites, run:"
	echo "[ sites list ]"
fi

# ##################

unset DOMAIN FNAME project_d scripts_f hook_f info_f nginx_enabled_f nginx_available_f ssl_d
