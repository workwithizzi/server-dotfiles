#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

export BIN=${0:a:h}

source "$BIN/utils/colors.sh"

# ##################
# Helper Function
sites_rename_help() {
	cmd_h2 "sites rename"
	cmd_h2_desc "Renames a site and all related hosting files"
	cmd_h2_desc "Does not affect actual project files."
	cmd_h2_opt_title "option 1"
	cmd_h2_opt "[old-name.com] original domain name of the site."
	cmd_h2_opt_title "option 2"
	cmd_h2_opt "[new-name.com] New domain name of the site."
}

# ##################
# Task Function
sites_rename_cmd() {
	# Get Domain
	if [[ -z "$1" ]]; then
		echo "What site do you want to remove? [example.com]"
		read -r OLD_DOMAIN
	else
		OLD_DOMAIN="$1"
	fi

	if [[ -z "$2" ]]; then
		echo "What site do you want to remove? [example.com]"
		read -r NEW_DOMAIN
	else
		NEW_DOMAIN="$2"
	fi

	# Filenames
	OLD_FNAME="${OLD_DOMAIN//./_}"
	NEW_FNAME="${NEW_DOMAIN//./_}"

	# ##################

	PROJECT_PATH="/var/www"
	NGINX_ENABLED_PATH="/etc/nginx/sites-enabled"
	NGINX_AVAILABLE_PATH="/etc/nginx/sites-available"
	SSL_PATH="/etc/letsencrypt/live"

	UPDATED=false

	# ##################
	# Rename Project Directory
	if [[ -d "$PROJECT_PATH/$OLD_DOMAIN" ]]; then
		mv "$PROJECT_PATH/$OLD_DOMAIN" "$PROJECT_PATH/$NEW_DOMAIN"
		UPDATED=true
	fi

	# ##################
	# Webhook
	if [[ -f "$HOOKS_PATH/$OLD_FNAME.json" ]]; then
		# Replace Text in file
		sudo sed -i -e "s/$OLD_FNAME/$NEW_FNAME/" "$HOOKS_PATH/$OLD_FNAME.json"
		sudo sed -i -e "s/$OLD_DOMAIN/$NEW_DOMAIN/" "$HOOKS_PATH/$OLD_FNAME.json"
		# Rename File
		mv "$HOOKS_PATH/$OLD_FNAME.json" "$HOOKS_PATH/$NEW_FNAME.json"
		UPDATED=true

		# Rebuild/Restart Webhook
		hooks stop
		hooks combine
		hooks start

	fi

	# ##################
	# Rename Deploy Script
	if [[ -f "$SCRIPTS_PATH/$OLD_FNAME.sh" ]]; then
		mv "$SCRIPTS_PATH/$OLD_FNAME.sh" "$SCRIPTS_PATH/$NEW_FNAME.sh"
		UPDATED=true
	fi

	# ##################
	# Info File
	if [[ -f "$INFO_PATH/$OLD_FNAME" ]]; then
		# Replace Text in file
		sudo sed -i -e "s/$OLD_FNAME/$NEW_FNAME/" "$INFO_PATH/$OLD_FNAME"
		sudo sed -i -e "s/$OLD_DOMAIN/$NEW_DOMAIN/" "$INFO_PATH/$OLD_FNAME"
		# Rename File
		mv "$INFO_PATH/$OLD_FNAME" "$INFO_PATH/$NEW_FNAME"
		UPDATED=true
	fi

	# ##################
	# Disable NGINX
	# Replace text in available file
	# Rename available file
	# Reload NGINX
	sites disable "$DOMAIN"
	if [[ -f "$NGINX_AVAILABLE_PATH/$OLD_DOMAIN" ]]; then
		# Replace Text in file
		sudo sed -i -e "s/$OLD_DOMAIN/$NEW_DOMAIN/" "$NGINX_AVAILABLE_PATH/$OLD_FNAME"
		# Rename File
		mv "$NGINX_AVAILABLE_PATH/$OLD_DOMAIN" "$NGINX_AVAILABLE_PATH/$NEW_DOMAIN"
		UPDATED=true
	fi
	sites enable "$DOMAIN"

	# ##################
	# Delete SSL Cert
	if [[ -d "$SSL_PATH/$DOMAIN" ]]; then
		ssl delete "$DOMAIN"
		UPDATED=true

		# Create new SSL Cert
		ssl add "$DOMAIN"
	fi

	# ##################
	# Reload NGINX
	sudo systemctl reload nginx

	# #####################################

	if [[ "$UPDATED" = "false" ]]; then
		echo "We couldn't find any files for $DOMAIN to update."
		echo "Try: [ sites list ] to see all available sites."
	fi

	# #####################################

	unset OLD_DOMAIN NEW_DOMAIN OLD_FNAME NEW_FNAME PROJECT_PATH NGINX_ENABLED_PATH NGINX_AVAILABLE_PATH SSL_PATH

}

# ##################
# Final Output Command
sites_rename() {
	if [[ "$1" = "help" ]]; then
		sites_rename_help
	else
		sites_rename_cmd "$1" "$2"
	fi
}
