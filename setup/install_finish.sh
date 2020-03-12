#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

doing() { echo "🚀  ""$*"; }

export DOTFILES="$HOME/_dotfiles"
export SETUP_D="$DOTFILES/setup"

# Admin-user Environment
# #####################################
source "$SETUP_D/user_config.sh"

# #####################################
# Node
doing "Installing Node/NPM/Yarn..."
sudo snap install node --classic --channel=10

# #####################################
doing "Installing 'build tools'..."
sudo apt-get install -y build-essential

# #####################################
doing "Installing NGINX..."
sudo apt install nginx -y

# Make sure NGINX allows all traffic
sudo ufw allow 'Nginx Full'

# Change the hash_bucket value to avoid possible
# memory problems from adding additional server names
sudo sed -i -e "s/# server_names_hash_bucket_size/server_names_hash_bucket_size/" "/etc/nginx/nginx.conf"

# #####################################
doing "Installing Let's Encrypt..."
sudo add-apt-repository ppa:certbot/certbot
# > enter

# Install Certbot’s Nginx package with apt:
sudo apt install python-certbot-nginx -y

# #####################################
doing "Installing 'Glances' for monitoring in the CLI..."
sudo curl -L https://bit.ly/glances | /bin/bash

# #####################################
doing "Installing Webhook..."
sudo apt-get install webhook
# https://tinyurl.com/hm8zz8z

# #####################################
doing "Authorizing DigitalOcean so we can use [doctl] cli"
echo "The auth token is either in 1Password or can be"
echo "created inside the D.O. account. Login, and go to"
echo "control panel > API > Generate New Access Token"
doctl auth init

# #####################################
echo "🎉🎉  The installation is finished!  🎉🎉"
