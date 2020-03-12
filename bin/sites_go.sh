#!/bin/bash
# shellcheck disable=SC1090,SC2034
#
# <sites go>
# #####################################

export BIN=${0:a:h}

source "$BIN/utils/colors.sh"

# ##################
# Helper Function
sites_go_help() {
	cmd_h2 "sites go"
	cmd_h2_desc "Takes you to a directory related to a site or sites"
	cmd_h2_opt_title "options:"
	cmd_h2_opt "no-option    : Base directory for all sites (/var/www)"
	cmd_h2_opt "info         : Base directory for all info files"
	cmd_h2_opt "scripts      : Base directory for all deploy scripts"
	cmd_h2_opt "hooks        : Base directory for all webhooks"
	cmd_h2_opt "[example.com]: Root directory for example.com"
}

# ##################
# Task Function
sites_go_cmd() {
	arg="$1"

	if [[ -z "$arg" ]]; then
		cd "/var/www" || return

	elif [[ "$arg" = "info" ]]; then
		cd "$INFO_PATH" || return

	elif [[ "$arg" = "scripts" || "$arg" = "script" ]]; then
		cd "$SCRIPTS_PATH" || return

	elif [[ "$arg" = "hooks" || "$arg" = "hook" ]]; then
		cd "$HOOKS_PATH" || return

	elif [[ "$arg" = "help" ]]; then
		sites_go_help

	else
		if [[ -d "/var/www/$arg" ]]; then
			cd "/var/www/$arg" || return
		else
			echo "Your query didn't match an available option."
			sites_go_help
			echo ""
			echo "To view all sites, run: [ sites list ]"
		fi
	fi

	unset arg
}

# ##################
# Final Output Command
sites_go() {
	if [[ "$1" = "help" ]]; then
		sites_go_help
	else
		sites_go_cmd "$1"
	fi
}
