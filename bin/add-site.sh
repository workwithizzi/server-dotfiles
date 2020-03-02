#!/bin/bash
# shellcheck disable=SC1090

# Temporary:
IP_ADDRESS="64.225.61.3"
BIN="$DOTFILES/bin"
default_owner="addy"
default_public_dir="public"
default_git_branch="master"

# #####################################

if [[ ! "$USER" = "root" ]]; then
	echo "You need to login as 'root' user before you can add a new site."
	return
fi

# Get the user input:
echo "Domain Name? [example.com]"
read -r DOMAIN

echo "Associated username (not 'root')?"
read -r OWNER
if [[ ! "$OWNER" ]]; then
	OWNER="$default_owner"
fi

echo "What do you want the site's public directory to be? [public]"
read -r PUBLIC_DIR
if [[ ! "$PUBLIC_DIR" ]]; then
	PUBLIC_DIR="$default_public_dir"
fi

read -r "REPLY?❓  "" Do you want to connect your site to Github? [y|n]  "
# Not in Git
if [[ $REPLY =~ ^[n]$ ]]; then
	GIT_INTEGRATION=false

	# Create the directory for NGINX
	sudo mkdir -p "/var/www/$DOMAIN/live/$PUBLIC_DIR"

	source "$BIN/add-html-placeholder.sh"

# In Git
else
	GIT_INTEGRATION=true
	echo "What's the HTTPS URL of your Github repo?"
	read -r REPO
	echo "What branch do you want to use? [master]"
	read -r BRANCH
	if [[ ! "$BRANCH" ]]; then
		BRANCH="$default_git_branch"
	fi

	# Create the directory for NGINX
	sudo mkdir -p "/var/www/$DOMAIN"

	git clone "$REPO" "/var/www/$DOMAIN/live"

	# Create deploy script
	source "$BIN/add-deploy-script.sh"
	# TODO: Add hooks template
fi

# if [[ "$GIT_INTEGRATION" = true ]]; then
# 	git clone "$REPO" "/var/www/$DOMAIN/live"

# 	# Create deploy script
# 	source "$BIN/deploy-template.sh"

# elif [[ "$GIT_INTEGRATION" = false ]]; then
# 	# # Create placeholder index.html
# 	# source "$BIN/index-html-template.sh"
# fi

# Switch to root user
# su - root

# Create a new server block for NGINX
source "$BIN/add-site-nginx.sh"

# Switch back
# su - "$OWNER"

# enable the site with NGINX
sudo ln -s "/etc/nginx/sites-available/$DOMAIN" "/etc/nginx/sites-enabled/"

# #####################################

# Assign owner and set permissions
assign_dir "$OWNER" "/var/www/$DOMAIN"

# #####################################

# SSL Cert
read -r "REPLY?❓  "" Do you want to add an SSL certificate? [y|n]  "
if [[ $REPLY =~ ^[n]$ ]]; then
	SSL_CERT=false

else
	SSL_CERT=true
	echo "#####################################"
	echo "Use this for completing the SSL cert:"
	echo "Email: [admin@workwithizzi.com]"
	# echo "1 - Agree           : [A]"
	# echo "2 - No              : [N]"
	echo "Redirect traffic: [2]"
	echo "#####################################"
	sudo certbot --nginx -d "$DOMAIN" -d "www.$DOMAIN"
fi

CREATED_DATE=$(date +"%d-%m-%y")
CREATED_TIME=$(date +"%H:%M:%S")

{
	echo "DOMAIN=\"$DOMAIN\""
	echo "OWNER=\"$OWNER\""
	echo "CREATED_DATE=\"$CREATED_DATE\""
	echo "CREATED_TIME=\"$CREATED_TIME\""
	echo "PUBLIC_DIR=\"$PUBLIC_DIR\""
	echo "GIT_INTEGRATION=\"$GIT_INTEGRATION\""
	echo "REPO=\"$REPO\""
	echo "BRANCH=\"$BRANCH\""
	echo "SSL_CERT=\"$SSL_CERT\""
	echo "DEPLOY_SECRET=\"$DEPLOY_SECRET\""
	echo "WEBHOOK_URL=\"http://$IP_ADDRESS:9000/hooks/$DOMAIN\""
} >>"/var/www/$DOMAIN/info"

# Assign owner and set permissions
assign_dir "$OWNER" "/var/www/$DOMAIN"

# Reload NGINX
_nginx reload
