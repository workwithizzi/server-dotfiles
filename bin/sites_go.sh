#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

# TODO: queries not working

if [[ -z "$1" ]]; then
	cd "var/www" || return

elif [[ "$1" = "info" ]]; then
	cd "$INFO_PATH" || return

elif [[ "$1" = "scripts" || "$1" = "script" ]]; then
	cd "$SCRIPTS_PATH" || return

elif [[ "$1" = "hooks" || "$1" = "hook" ]]; then
	cd "$HOOKS_PATH" || return

else
	if [[ -d "/var/www/$1" ]]; then
		cd "/var/www/$1" || return
	else
		echo "Your query needs to either match one of these options:"
		echo "hooks: Webhooks directory"
		echo "scripts: Deploy Scripts directory"
		echo "info: Info Files directory"
		echo "[empty]: Base directory for all projects"
		echo "[example.com] Directory of a specific site"
		echo ""
		echo "To view all sites, run: [ sites list ]"
	fi
fi
