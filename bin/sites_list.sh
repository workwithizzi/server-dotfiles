#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

export BIN=${0:a:h}
source "$BIN/utils/colors.sh"

# ##################
# Helper Function
sites_list_help() {
	cmd_h2 "sites list"
	cmd_h2_desc "Simple command that prints list of all active sites."
}

# ##################
# Task Function
sites_list_cmd() {
	echo "Active Sites:"
	ls /etc/nginx/sites-enabled
}

# ##################
# Final Output Command
sites_list() {
	if [[ "$1" = "help" ]]; then
		sites_list_help
	else
		sites_list_cmd
	fi
}
