#!/usr/bin/env bash
# shellcheck disable=SC1090

doing() { echo "🚀  ""$*"; }

export DOTFILES="$HOME/_dotfiles"

# #####################################

# Admin-user Environment
# #####################################
export NEW_USER="$USER"
source "$DOTFILES/bin/user-config.sh"
unset NEW_USER

# Node
# #####################################
doing "Installing Node/NPM/Yarn"
sudo snap install node --classic --channel=10

# Install build tools:
doing "Installing 'build-essential'"
sudo apt-get install -y build-essential

# NGINX
# #####################################
doing "Installing NGINX"
sudo apt install nginx -y

# Make sure NGINX allows all traffic
sudo ufw allow 'Nginx Full'

# Change the hash_bucket value to avoid possible
# memory problems from adding additional server names
sudo sed -i -e "s/# server_names_hash_bucket_size/server_names_hash_bucket_size/" "/etc/nginx/nginx.conf"

# Let's Encrypt
# #####################################
doing "Installing Let's Encrypt"
sudo add-apt-repository ppa:certbot/certbot
# > enter

# Install Certbot’s Nginx package with apt:
sudo apt install python-certbot-nginx -y

# Glances (server monitoring)
# #####################################
sudo curl -L https://bit.ly/glances | /bin/bash

# Webhook
# https://tinyurl.com/hm8zz8z
# #####################################
doing "Installing Webhook and opening port '9000'"
sudo apt-get install webhook

# Authorize DigitalOcean (doctl)
# #####################################
doing "Authorizing DigitalOcean so we can use [doctl] cli"
echo "The auth token is either in 1Password or can be"
echo "created inside the D.O. account. Login, and go to"
echo "control panel > API > Generate New Access Token"
doctl auth init

echo "🎉  The installation is finished!"
