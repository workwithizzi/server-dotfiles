#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

export BIN=${0:a:h}
source "$BIN/utils/colors.sh"

# ##################
# Helper Function
sites_info_help() {
	cmd_h2 "sites info"
	cmd_h2_desc "Prints info about a specific site"
	cmd_h2_opt_title "options:"
	cmd_h2_opt "[example.com] Domain name of the site."
}

# ##################
# Task Function
sites_info_cmd() {
	# TODO: Add select option to command
	# Get Domain
	if [[ -z "$1" ]]; then
		echo "What site do you want to info on? [example.com]"
		read -r DOMAIN
	else
		DOMAIN="$1"
	fi

	# Filename
	FNAME="${DOMAIN//./_}"

	# ##################
	# Get info if file exists
	if [[ -f "$INFO_PATH/$FNAME" ]]; then
		cat "$INFO_PATH/$FNAME"
	else
		echo "Something went wrong. We can't find info for $DOMAIN"
		echo "Try [ sites list ] to see which sites are available"
	fi

	unset DOMAIN FNAME
}

# ##################
# Final Output Command
sites_info() {
	if [[ "$1" = "help" ]]; then
		sites_info_help
	else
		sites_info_cmd "$1"
	fi
}
