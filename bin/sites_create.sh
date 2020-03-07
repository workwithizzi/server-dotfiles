#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

source "$BIN/utils/ask.sh"

if [[ ! "$USER" = "root" ]]; then
	echo "You need to be logged in as 'root' before you can add a new site."
	return
fi

export BIN=${0:a:h}
CREATED_DATE=$(date +"%d-%m-%y")
CREATED_TIME=$(date +"%H:%M:%S")

[[ -f "$HOME/.env" ]] && source "$HOME/.env"

# #####################################

# Get the user input:
echo "Domain Name (example.com)?"
read -r DOMAIN

# Make sure the site doesn't already exist
source "$BIN/sites_check_domain.sh" "$DOMAIN"

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
	echo "What branch do you want to use? [Default = $ENV_BRANCH]"
	read -r BRANCH
	if [[ -z "$BRANCH" ]]; then
		BRANCH="$ENV_BRANCH"
	fi

	rm -rf "/var/www/$DOMAIN/live"
	git clone "$REPO" "/var/www/$DOMAIN/live"
	# TODO: Add checkout command if branch isn't master

	# TODO: Create deploy script
	# source "$BIN/add_deploy_script.sh"
	# TODO: Create webhook file
	# source "$BIN/hooks_create.sh"

else
	# No
	export GIT_INTEGRATION=false
	# TODO: Add placeholder index.html file
	# source "$BIN/add_html_placeholder.sh"
fi

# #####################################
# TODO: Configure NGINX
source "$BIN/add_site_nginx.sh"

# #####################################
# SSL Cert
read -r "REPLY?❓  "" Do you want to add an SSL certificate? [y|n]  "
if ask "Do you want to add an SSL certificate?" Y; then
	export SSL_CERT=true
	# TODO: Add ssl cert
	# source "$BIN/add_site_ssl.sh"
else
	export SSL_CERT=false
fi

# #####################################
# Create an 'info' file for reference

# sudo touch "$INFO_PATH/$FNAME"

# {
# 	echo "DOMAIN=\"$DOMAIN\""
# 	echo "OWNER=\"$OWNER\""
# 	echo "CREATED_DATE=\"$CREATED_DATE\""
# 	echo "CREATED_TIME=\"$CREATED_TIME\""
# 	echo "PUBLIC_DIR=\"$PUBLIC_DIR\""
# 	echo "GIT_INTEGRATION=\"$GIT_INTEGRATION\""
# 	echo "REPO=\"$REPO\""
# 	echo "BRANCH=\"$BRANCH\""
# 	echo "SSL_CERT=\"$SSL_CERT\""
# 	echo "DEPLOY_SECRET=\"$DEPLOY_SECRET\""
# 	echo "WEBHOOK_URL=\"http://$ENV_WEBHOOK_URL:9000/hooks/$FNAME\""
# } >>"$INFO_PATH/$FNAME"

# # Assign owner and set permissions
# assign_file "$OWNER" "$INFO_PATH/$FNAME"
# assign_dir "$OWNER" "/var/www/$DOMAIN"

# # # Reload NGINX
# # _nginx reload

# unset DOMAIN FNAME OWNER CREATED_DATE CREATED_TIME PUBLIC_DIR GIT_INTEGRATION REPO BRANCH SSL_CERT DEPLOY_SECRET IP_ADDRESS
