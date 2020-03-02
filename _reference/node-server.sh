#!/usr/bin/env bash

# Automated setup:
# https://www.digitalocean.com/community/tutorials/automating-initial-server-setup-with-ubuntu-18-04


# Make sure everything is up to date
# sudo apt update -y
# sudo apt upgrade -y


# # SSH Keys
# # #####################################

# # (on your local machine) Add public keys to .ssh
# pbcopy > ~/.ssh/id_rsa.pub

# # Then SSH into the new server:

# # Create directory if it doesn't exist
# mkdir -p ~/.ssh

# # Create and open the authorized_keys fle
# nano ~/.ssh/authorized_keys

# # Make sure permissions and ownership of the files are correct
# chmod -R go= ~/.ssh
# chown -R $USER:$USER ~/.ssh


# # DigitalOcean
# # #####################################

# if [[ ! -d "/opt/digitalocean/do-agent" ]]; then
# 	echo "🚀 Upgrading DigitalOceans Metrics Agent:"
# 	# Uninstall the legacy metrics agent.
# 	sudo apt-get purge do-agent

# 	# Install the current metrics agent.
# 	curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash
# fi

# # Doctl (DigitalOcean's Command-Line tool)
# snap install doctl



# # ZSH
# # #####################################

# if [[ ! -f "$HOME/.zshrc" ]]; then
# 	echo "🚀 Setting up ZSH"
# 	# Install ZSH
# 	sudo apt install zsh

# 	# Change the default shell of the root user to zsh
# 	chsh -s /usr/bin/zsh root

# 	# Install Oh-My-ZSH
# 	sudo wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

# 	# Install syntax highlighting
# 	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# 	# Install autosuggestions
# 	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# fi

# if [[ -f "$HOME/.zshrc" ]]; then
# 	echo "🚀 Replacing default .zshrc with our own"
# 	rm -rf "$HOME/.zshrc"
# 	wget -O ~/.zshrc https://raw.githubusercontent.com/workwithizzi/server-dotfiles/master/zshrc
# 	wget -O ~/.oh-my-zsh/custom/themes/simple.zsh-theme https://raw.githubusercontent.com/workwithizzi/server-dotfiles/master/simple.zsh-theme
# fi

# if [[ -f "$HOME/.bashrc" ]]; then
# 	echo "🚀 Moving old bash files to 'old/' so things stay clean"
# 	mkdir "$HOME/old"
# 	mv "$HOME/.bashrc" "$HOME/old/.bashrc"
# 	mv "$HOME/.bash_history" "$HOME/old/.bash_history"
# 	echo "ℹ️ You can delete the 'old/' directory whenever you want."
# fi

# rm -rf "$HOME/install"





# # Make sure that the firewall allows SSH connections so that we can log back in next time.
# ufw allow OpenSSH

# # enable the firewall
# ufw enable

# Copy SSH keys to new user
rsync --archive --chown=$NEWUSER:$NEWUSER ~/.ssh /home/$NEWUSER



# Node
# #####################################


# Install PPA (package manager)
# curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
# sudo apt-get install -y nodejs

# snap install node --classic --channel=10

# # To compile and install native addons, install build tools:
# apt-get install -y build-essential


# NGINX
# #####################################

# Install NGINX
# apt install nginx -y

# # Only allow traffic on port 80
# # ufw allow 'Nginx HTTP'

# # Make sure NGINX allows all traffic
# sudo ufw allow 'Nginx Full'

# Let's Encrypt
# #####################################

# # Install Certbot
# sudo add-apt-repository ppa:certbot/certbot

# # Install Certbot’s Nginx package with apt:
# sudo apt install python-certbot-nginx -y



# Webhook
# https://tinyurl.com/hm8zz8z
# #####################################
sudo apt-get install webhook





# Authorize DigitalOcean (doctl)
doctl auth init
# Get the token from 1Pass or generate a new one from DO
# Login to control panel > API > Generate New Access Token
# Save the token to 1pass