#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

export BIN=${0:a:h}
source "$BIN/utils/colors.sh"

sites() {
	# if [[ "$1" = "add" ]] && [[ ! "$2" ]]; then
	# 	echo "Domain Name? [example.com]"
	# 	read -r DOMAIN
	# else
	# 	DOMAIN="$2"
	# fi
	# FNAME="${DOMAIN//./_}"

	# ####################

	if [[ "$1" = "create" ]]; then
		# echo "create"
		source "$BIN/sites_create.sh"

	elif [[ "$1" = "remove" ]]; then
		echo "remove"

	elif [[ "$1" = "list" ]]; then
		echo "list"

	elif [[ "$1" = "go" ]]; then
		echo "go"

	elif [[ "$1" = "enable" ]]; then
		echo "enable"

	elif [[ "$1" = "disable" ]]; then
		echo "disable"

	elif [[ "$1" = "info" ]]; then
		echo "info"

	elif [[ "$1" = "rename" ]]; then
		echo "rename"

	elif [[ "$1" = "defaults" ]]; then
		echo "defaults-add"
		echo "defaults-view"
		echo "defaults-edit"

	else
		echo "Send help"

	fi
}
