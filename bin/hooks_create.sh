#!/bin/bash
# shellcheck disable=SC1090,SC2034
# Args
# - 1: domain
# - 2: owner
# #####################################

export BIN=${0:a:h}

# Get Defaults
[[ -f "$HOME/.defaults" ]] && source "$HOME/.defaults"

# Make Hooks dir
if [[ ! -d "$HOOKS_PATH" ]]; then
	sudo mkdir -p "$HOOKS_PATH"
fi

# ##################
# Get Domain
if [[ -z "$1" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN
else
	DOMAIN="$1"
fi
# Filename
FNAME="${DOMAIN//./_}"

# Make sure the site doesn't already exist
source "$BIN/check_domain_exists.sh" "$DOMAIN"
if [[ "$hook_exists" = "true" ]]; then
	echo "There's already a webhook for this site."
	echo "Try [ sites list ] to see all available sites."
fi

# ##################
# Get Owner
if [[ -z "$2" ]]; then
	echo "Associated username? [Default = $ENV_SITE_OWNER]"
	read -r OWNER
else
	OWNER="$2"
fi
if [[ -z "$OWNER" ]]; then
	OWNER="$ENV_SITE_OWNER"
fi

# ##################
# Get Secret

# Create a random secret to use as fallback
default_secret=$(date | md5sum)
# remove spaces
default_secret="${default_secret// /}"
# remove dashes
default_secret="${default_secret//-/}"

echo "What is the secret key that you want to use for your webhook?"
echo "[Default generated secret = $default_secret]"
read -r DEPLOY_SECRET
if [[ -z "$DEPLOY_SECRET" ]]; then
	DEPLOY_SECRET="$default_secret"
fi

# #####################################

# Create Hooks
sudo touch "$HOOKS_PATH/$FNAME.json"

{
	echo "["
	echo "  {"
	echo "    \"id\": \"$FNAME\","
	echo "    \"execute-command\": \"$SCRIPTS_PATH/$FNAME.sh\","
	echo "    \"command-working-directory\": \"/var/www/$DOMAIN/live/\","
	echo "    \"response-message\": \"Executing script...\","
	echo "    \"trigger-rule\": {"
	echo "      \"match\": {"
	echo "        \"type\": \"payload-hash-sha1\","
	echo "        \"secret\": \"$DEPLOY_SECRET\","
	echo "        \"parameter\": {"
	echo "          \"source\": \"header\","
	echo "          \"name\": \"X-Hub-Signature\""
	echo "        }"
	echo "      }"
	echo "    }"
	echo "  }"
	echo "]"
} >>"$HOOKS_PATH/$FNAME.json"

assign_file "$OWNER" "$HOOKS_PATH/$FNAME.json"
