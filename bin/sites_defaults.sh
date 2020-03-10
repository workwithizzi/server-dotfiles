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

opt="$1"

if [[ -f "$HOME/.defaults" ]]; then
	ENV_EXISTS=true
fi

# ##################

defaults_help() {
	echo "<sites defaults> - Helps you configure default settings"
	echo "that can be used when creating and working with sites."
	echo ""
	echo "options:"
	echo "create : Create the file is it doesn't exist"
	echo "view   : View the current defaults"
	echo "update : Update the current defaults"
}

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
		defaults_help
	fi

# ##################
elif [[ "$opt" = "view" ]]; then
	if [[ -z "$ENV_EXISTS" ]]; then
		echo "Looks like you haven't added any default options. Here's some help:"
		defaults_help
	else
		cat "$HOME/.defaults"
	fi

# ##################
elif [[ "$opt" = "update" ]]; then
	if [[ -z "$ENV_EXISTS" ]]; then
		echo "Looks like you haven't added any default options. Here's some help:"
		defaults_help
	else
		nano "$HOME/.defaults"
	fi

else
	# Send Help
	defaults_help
fi

# #####################################

unset opt ENV_EXISTS
