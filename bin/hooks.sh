#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
export BIN=${0:a:h}

source "$BIN/colors.sh"

# Manage Webhook
hooks() {

	if [[ "$1" = "create" || "$1" = "remove" || "$1" = "view" ]] && [[ ! "$2" ]]; then
		echo "Domain Name? [example.com]"
		read -r DOMAIN
	else
		DOMAIN="$2"
	fi
	FNAME="${DOMAIN//./_}"

	if [[ "$1" = "create" ]]; then
		echo "Creating Hook..."
		source "$BIN/hooks_create.sh" "$DOMAIN"
		# Reload main hooks file
		node "$BIN/merge_hooks/index.js" "$HOOKS_PATH" "$HOME/hooks.json"

	elif [[ "$1" = "remove" ]]; then
		echo "Removing Hook..."
		source "$BIN/hooks_remove.sh" "$DOMAIN"
		# Reload main hooks file
		node "$BIN/merge_hooks/index.js" "$HOOKS_PATH" "$HOME/hooks.json"

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
		echo "${BPurple}<hooks> : Shortcuts for working with Webhook${Reset}"
		echo "commands:"
		echo "create : Creates the domain's hook file and adds it to the \"master\" hooks file."
		echo "remove : Removes the domain's hook file and removes it from the \"master\" hooks file."
		echo "stop   : Stops the webhook process using <kill> command"
		echo "start  : Starts webhook with hooks in the \"master\" hooks file."
		echo "restart: Stops. Then starts webhook. Obviously."
		echo ""
		echo "options:"
		echo "[create|remove] : You can also pass the domain name as a second argument"
		echo "[start|restart] : Use [-v] as a second argument to start webhook in 'verbose' mode."
	fi
}
