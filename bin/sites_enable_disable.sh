#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

# Get Domain
if [[ -z "$2" ]]; then
	echo "What site do you want to remove? [example.com]"
	read -r DOMAIN
else
	DOMAIN="$2"
fi

# NGINX Paths
enabled_f="/etc/nginx/sites-enabled/$DOMAIN"
available_f="/etc/nginx/sites-available/$DOMAIN"

# ##################
# Enable
if [[ "$1" = "enable" ]]; then
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
		echo "Something went wrong. $DOMAIN is not available."
		# TODO: NGINX - Add function for creating nginx for existing site
		# echo "Make sure site exists and then try [ _nginx create $DOMAIN ]"
		return
	fi

fi

# ##################
# Disable
if [[ "$1" = "disable" ]]; then
	# Make sure site is enabled
	if [[ -f "$enabled_f" ]]; then
		sudo rm "$enabled_f"
		# TODO: NGINX - Make sure these commands are correct
		_nginx reload
		_nginx check
	else
		echo "Something went wrong."
		echo "$DOMAIN is not currently enabled in NGINX"
		echo "Try [ sites list ] to see all enables sites."
		return
	fi
fi

# #####################################
unset DOMAIN enabled_f available_f
