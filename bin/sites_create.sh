#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
# #####################################

source "$BIN/utils/ask.sh"

if [[ ! "$USER" = "root" ]]; then
	echo "You need to be logged in as 'root' before you can add a new site."
	return
fi

export BIN=${0:a:h}
CREATED_DATE=$(date +"%d-%m-%y")
CREATED_TIME=$(date +"%H:%M:%S")

[[ -f "$HOME/.defaults" ]] && source "$HOME/.defaults"

# #####################################

# Get the user input:
echo "Domain Name (example.com)?"
read -r DOMAIN

# Make sure the site doesn't already exist
source "$BIN/check_domain_exists.sh" "$DOMAIN"
if [[ "$site_exists" = "true" ]]; then
	echo "There seems to be some files associated with $DOMAIN."
	echo "Try running [ sites list ] to see all available sites."
	return
fi

# #####################################

echo "Which user is the owner of this site? [Default = $ENV_SITE_OWNER"
read -r OWNER
if [[ -z "$OWNER" ]]; then
	OWNER="$ENV_SITE_OWNER"
fi

echo "What do you want the site's public directory to be? [Default = $ENV_PUBLIC_DIR]"
read -r PUBLIC_DIR
if [[ -z "$PUBLIC_DIR" ]]; then
	PUBLIC_DIR="$ENV_PUBLIC_DIR"
fi

# Create the website directory
sudo mkdir -p "/var/www/$DOMAIN/live"

# Replace '.' with '_' to use for file names
export FNAME="${DOMAIN//./_}"

# #####################################
# Connect to Github
if ask "Do you want to connect your site to Github?" Y; then
	# Yes
	export GIT_INTEGRATION=true
	echo "What's the HTTPS URL of your Github repo?"
	read -r REPO

	rm -rf "/var/www/$DOMAIN/live"
	git clone "$REPO" "/var/www/$DOMAIN/live"

	# ##################
	# Branch
	echo "What branch do you want to use? [Default = $ENV_BRANCH]"
	read -r BRANCH
	if [[ -z "$BRANCH" ]]; then
		BRANCH="$ENV_BRANCH"
	fi

	if [[ "$BRANCH" != "master" ]]; then
		git checkout "$BRANCH"
	fi

	# ##################
	# Create Deploy Script
	source "$BIN/sites_deploy_script.sh" "$DOMAIN" "$OWNER" "$BRANCH"

	# ##################
	# Create Hook
	source "$BIN/hooks_create.sh" "$DOMAIN" "$OWNER"

else
	# No
	export GIT_INTEGRATION=false
	# Create index.html placeholder
	source "$BIN/sites_html_placeholder.sh" "$DOMAIN" "$OWNER" "$PUBLIC_DIR"
fi

# #####################################
# NGINX
source "$BIN/nginx_create.sh" "$DOMAIN" "$OWNER" "$PUBLIC_DIR"
# enable the site with NGINX
# sudo ln -s "/etc/nginx/sites-available/$DOMAIN" "/etc/nginx/sites-enabled/"
sites enable "$DOMAIN"
# Reload NGINX
_nginx reload

# #####################################
# SSL Cert
if ask "Do you want to add an SSL certificate?" Y; then
	export SSL_CERT=true
	source "$BIN/ssl_create.sh" "$DOMAIN"
else
	export SSL_CERT=false
fi

# #####################################
# Create an 'info' file for reference

sudo touch "$INFO_PATH/$FNAME"

{
	echo "DOMAIN=\"$DOMAIN\""
	echo "OWNER=\"$OWNER\""
	echo "CREATED_DATE=\"$CREATED_DATE\""
	echo "CREATED_TIME=\"$CREATED_TIME\""
	echo "PUBLIC_DIR=\"$PUBLIC_DIR\""
	echo "SSL_CERT=\"$SSL_CERT\""
	echo "GIT_INTEGRATION=\"$GIT_INTEGRATION\""
} >>"$INFO_PATH/$FNAME"

if [[ "$GIT_INTEGRATION" ]]; then

	{
		echo "REPO=\"$REPO\""
		echo "BRANCH=\"$BRANCH\""
		echo "DEPLOY_SECRET=\"$DEPLOY_SECRET\""
		echo "WEBHOOK_URL=\"http://$ENV_WEBHOOK_URL:9000/hooks/$FNAME\""
	} >>"$INFO_PATH/$FNAME"

fi

# Assign owner and set permissions
assign_file "$OWNER" "$INFO_PATH/$FNAME"
assign_dir "$OWNER" "/var/www/$DOMAIN"

# Reload NGINX
_nginx reload

unset DOMAIN FNAME OWNER CREATED_DATE CREATED_TIME PUBLIC_DIR GIT_INTEGRATION REPO BRANCH SSL_CERT DEPLOY_SECRET IP_ADDRESS
