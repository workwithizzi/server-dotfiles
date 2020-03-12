#!/bin/bash
# shellcheck disable=SC1090,SC2034
#
# Args
# 1 - create
# 1 - view
# 1 - update
# 1 - [empty] = prints help info
# #####################################

export BIN=${0:a:h}

source "$BIN/utils/colors.sh"

# ##################
# Helper Function
sites_defaults_help() {
	cmd_h2 "sites defaults"
	cmd_h2_desc "Configures default settings to be used"
	cmd_h2_desc "when creating and working with sites."
	cmd_h2_opt_title "options:"
	cmd_h2_opt "[empty] : Prints this help info"
	cmd_h2_opt "create  : Create defaults if they don't exist"
	cmd_h2_opt "update  : Update current defaults"
	cmd_h2_opt "view    : View current defaults"
}

# ##################
# Task Function
sites_defaults_cmd() {
	opt="$1"

	if [[ -f "$HOME/.defaults" ]]; then
		ENV_EXISTS=true
	fi

	# ##################
	if [[ "$opt" = "create" ]]; then
		if [[ -z "$ENV_EXISTS" ]]; then
			echo "Answer the following questions and so I can set your defaults"
			echo "What's the base url for the server. You can also use the server IP address."
			read -r ENV_WEBHOOK_URL

			echo "Which user (not 'root') do you want the owner of new sites to be?"
			read -r ENV_SITE_OWNER

			echo "What do you want the default public directory to be for each site [i.e. public]"
			read -r ENV_PUBLIC_DIR

			echo "If connecting to Git, what do you want the default branch to be? [i.e. master]"
			read -r ENV_BRANCH

			{
				echo "#!/bin/bash"
				echo "ENV_WEBHOOK_URL=\"$ENV_WEBHOOK_URL\""
				echo "ENV_SITE_OWNER=\"$ENV_SITE_OWNER\""
				echo "ENV_PUBLIC_DIR=\"$ENV_PUBLIC_DIR\""
				echo "ENV_BRANCH=\"$ENV_BRANCH\""
			} >>"$HOME/.defaults"

		else
			echo "Looks like you've already created default options. Here's some help:"
			sites_defaults_help
		fi

	# ##################
	elif [[ "$opt" = "view" ]]; then
		if [[ -z "$ENV_EXISTS" ]]; then
			echo "Looks like you haven't added any default options. Here's some help:"
			sites_defaults_help
		else
			cat "$HOME/.defaults"
		fi

	# ##################
	elif [[ "$opt" = "update" ]]; then
		if [[ -z "$ENV_EXISTS" ]]; then
			echo "Looks like you haven't added any default options. Here's some help:"
			sites_defaults_help
		else
			nano "$HOME/.defaults"
		fi

	else
		# Send Help
		sites_defaults_help
	fi

	# ##################

	unset opt ENV_EXISTS
}

# ##################
# Final Output Command
sites_defaults() {
	if [[ "$1" = "help" ]]; then
		sites_defaults_help
	else
		sites_defaults_cmd "$1"
	fi
}
