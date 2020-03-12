#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

source "$BIN/utils/colors.sh"

# ##################
# Helper Function
sites_enable_help() {
	cmd_h2 "sites enable"
	cmd_h2_desc "Enable a site in NGINX"
	cmd_h2_opt_title "options:"
	cmd_h2_opt "[example.com]:" "Domain name of the site."
}

# ##################
# Task Function
sites_enable_cmd() {
	# Get Domain
	if [[ -z "$1" ]]; then
		echo "Which site do you want to enable? [example.com]"
		read -r DOMAIN
	else
		DOMAIN="$1"
	fi

	# NGINX Paths
	enabled_f="/etc/nginx/sites-enabled/$DOMAIN"
	available_f="/etc/nginx/sites-available/$DOMAIN"

	# Make sure site isn't already enabled
	if [[ -f "$enabled_f" ]]; then
		echo "$DOMAIN is already enabled in NGINX"
		return

	# Make sure site is available
	elif [[ -f "$available_f" ]]; then

		# Do the things
		sudo ln -s "$available_f" "$enabled_f"
		# TODO: NGINX - Make sure these commands are correct
		_nginx reload
		_nginx check

	# If not available
	else
		echo "Something went wrong, $DOMAIN is not available."
		# TODO: NGINX - Add function for creating nginx for existing site
		# echo "Make sure site exists and then try [ _nginx create $DOMAIN ]"
		return
	fi

	unset DOMAIN enabled_f available_f
}

# ##################
# Final output command
sites_enable() {
	if [[ "$1" = "help" ]]; then
		sites_enable_help
	else
		sites_enable_cmd "$1"
	fi
}

# #####################################

# ##################
# Helper Function
sites_disable_help() {
	cmd_h2 "sites disable"
	cmd_h2_desc "Disable a site in NGINX so that it's not accessible online"
	cmd_h2_opt_title "options:"
	cmd_h2_opt "[example.com]:" "Domain name of the site."
}

# ##################
# Task Function
sites_disable_cmd() {
	# Get Domain
	if [[ -z "$1" ]]; then
		echo "Which site do you want to disable? [example.com]"
		read -r DOMAIN
	else
		DOMAIN="$1"
	fi

	# Make sure site is enabled
	if [[ -f "/etc/nginx/sites-enabled/$DOMAIN" ]]; then
		sudo rm "/etc/nginx/sites-enabled/$DOMAIN"
		# TODO: NGINX - Make sure these commands are correct
		_nginx reload
		_nginx check
	else
		echo "Something went wrong."
		echo "$DOMAIN is not currently enabled in NGINX"
		echo "Try [ sites list ] to see all enables sites."
		return
	fi

	unset DOMAIN
}

# ##################
# Final output command
sites_disable() {
	if [[ "$1" = "help" ]]; then
		sites_disable_help
	else
		sites_disable_cmd "$1"
	fi
}
