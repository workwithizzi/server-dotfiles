#!/bin/bash
# shellcheck disable=SC1090,SC2034

# Get Info
if [[ ! "$1" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN
else
	DOMAIN="$1"
fi

# If $DOMAIN is defined, then these be too
echo "Associated username? [Default = $ENV_SITE_OWNER]"
read -r OWNER
if [[ ! "$OWNER" ]]; then
	OWNER="$ENV_SITE_OWNER"
fi

FNAME="${DOMAIN//./_}"

# TODO: Add a way to create a unique secret for the deploy
echo "What is the secret key that you want to use for your webhook?"
read -r DEPLOY_SECRET

# #####################################

if [[ ! -d "$HOOKS_PATH" ]]; then
	sudo mkdir -p "$HOOKS_PATH"
fi

# If hook file doesn't exist, create it using the template
# and make the file available to webhook
if [[ ! -f "$HOOKS_PATH/$FNAME.json" ]]; then
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

else
	echo "Looks like there's already a hook with this name."
fi
