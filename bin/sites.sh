#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

export BIN=${0:a:h}
# source "$BIN/utils/colors.sh"

sites() {

	if [[ "$1" = "create" ]]; then
		source "$BIN/sites_create.sh"
		sites_create "$2"

	elif [[ "$1" = "remove" ]]; then
		source "$BIN/sites_remove.sh"
		sites_remove "$2"

	elif [[ "$1" = "list" ]]; then
		source "$BIN/sites_list.sh"
		sites_list "$2"

	elif [[ "$1" = "go" ]]; then
		source "$BIN/sites_go.sh"
		sites_go "$2"

	elif [[ "$1" = "enable" ]]; then
		source "$BIN/sites_enable_disable.sh"
		sites_enable "$2"

	elif [[ "$1" = "disable" ]]; then
		source "$BIN/sites_enable_disable.sh"
		sites_disable "$2"

	elif [[ "$1" = "info" ]]; then
		source "$BIN/sites_info.sh"
		sites_info "$2"

	elif [[ "$1" = "rename" ]]; then
		source "$BIN/sites_rename.sh"
		sites_rename "$2" "$3"

	elif [[ "$1" = "defaults" ]]; then
		source "$BIN/sites_defaults.sh"
		sites_defaults "$2"

	else
		source "$BIN/sites_help.sh"
	fi
}
