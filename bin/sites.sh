#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

export BIN=${0:a:h}
source "$BIN/utils/colors.sh"

sites() {
	# if [[ "$1" = "remove" ]] && [[ ! "$2" ]]; then
	# 	echo "Domain Name? [example.com]"
	# 	read -r DOMAIN
	# else
	# 	DOMAIN="$2"
	# fi
	# FNAME="${DOMAIN//./_}"

	# ####################

	if [[ "$1" = "create" ]]; then
		source "$BIN/sites_create.sh"

	elif [[ "$1" = "remove" ]]; then
		# Pass domain name if provided
		source "$BIN/sites_remove.sh" "$2"

	elif [[ "$1" = "list" ]]; then
		echo "Active Sites:"
		ls /etc/nginx/sites-enabled

	elif [[ "$1" = "go" ]]; then
		source "$BIN/sites_go.sh"

	elif [[ "$1" = "enable" ]]; then
		source "$BIN/sites_enable_disable.sh" "enable" "$2"

	elif [[ "$1" = "disable" ]]; then
		source "$BIN/sites_enable_disable.sh" "disable" "$2"

	elif [[ "$1" = "info" ]]; then
		source "$BIN/sites_info.sh" "$2"

	elif [[ "$1" = "rename" ]]; then
		source "$BIN/sites_rename.sh" "$2" "$3"

	elif [[ "$1" = "defaults" ]]; then
		echo "defaults-add"
		echo "defaults-view"
		echo "defaults-edit"

	else
		echo "Send help"

	fi
}
