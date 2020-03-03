#!/bin/bash

# Get Info
if [[ ! "$DOMAIN" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN

	# If $DOMAIN is defined, then these be too
	echo "Associated username? [Default = $ENV_SITE_OWNER"
	read -r OWNER
	if [[ ! "$OWNER" ]]; then
		OWNER="$ENV_SITE_OWNER"
	fi
	echo "What git branch do you want to use? [Default = $ENV_BRANCH]"
	read -r BRANCH
	if [[ ! "$BRANCH" ]]; then
		BRANCH="$ENV_BRANCH"
	fi
fi

# #####################################

if [[ ! -d "$SCRIPTS_PATH" ]]; then
	sudo mkdir -p "$SCRIPTS_PATH"
fi

sudo touch "$SCRIPTS_PATH/$CLEAN_DOMAIN.sh"

{
	echo "#!/bin/bash"
	echo "git fetch --all"
	echo "git checkout --force \"origin/$BRANCH\""
} >>"$SCRIPTS_PATH/$CLEAN_DOMAIN.sh"

assign_file "$OWNER" "$SCRIPTS_PATH/$CLEAN_DOMAIN.sh"
