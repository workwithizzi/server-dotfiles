#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
# export BIN=${0:a:h}

source "$BIN/utils/colors.sh"

# Manage Webhook
hooks() {

	if [[ "$1" = "create" || "$1" = "remove" || "$1" = "view" ]] && [[ ! "$2" ]]; then
		echo "Domain Name? [example.com]"
		read -r DOMAIN
	else
		DOMAIN="$2"
	fi
	FNAME="${DOMAIN//./_}"

	if [[ "$1" = "combine" ]]; then
		echo "Creating 'master' hooks.json file..."
		node "$BIN/merge_hooks/index.js" "$HOOKS_PATH" "$HOME/hooks.json"

	elif [[ "$1" = "create" ]]; then
		echo "Creating Hook..."
		source "$BIN/hooks_create.sh" "$DOMAIN"
		# Reload main hooks file
		hooks combine

	elif [[ "$1" = "remove" ]]; then
		echo "Removing Hook..."
		source "$BIN/hooks_remove.sh" "$DOMAIN"
		# Reload main hooks file
		hooks combine

	elif [[ "$1" = "view" ]]; then
		echo "Hook info for $DOMAIN:"
		if [[ -f "$HOOKS_PATH/$FNAME" ]]; then
			cat "$HOOKS_PATH/$FNAME"
		else
			echo "Looks like there's not a hook for $DOMAIN"
		fi

	elif [[ "$1" = "stop" ]]; then
		echo "Stopping Webhook..."
		webhookid=$(pidof webhook)
		kill "$(pidof webhook)"

	elif [[ "$1" = "start" ]]; then
		echo "Starting Webhook..."
		if [[ "$2" = -v ]]; then
			webhook -hooks "$HOME/hooks.json"
		else
			nohup webhook -hooks "$HOME/hooks.json" &
		fi

	elif [[ "$1" = "restart" ]]; then
		# echo "Restart Webhook"
		hooks stop
		hooks start "$2"

	else
		source "$BIN/hooks_help.sh"
	fi
}
