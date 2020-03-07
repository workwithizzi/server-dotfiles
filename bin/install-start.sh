#!/usr/bin/env bash
# shellcheck disable=SC1090

doing() { echo "🚀  ""$*"; }

export DOTFILES="$HOME/_dotfiles"

# #####################################

# Resources
# #####################################
# Automated setup script: https://tinyurl.com/ydaw7zx3

# 'root' Environment
# #####################################
if [[ ! -f "$HOME/.zshrc" ]]; then
	doing "Setting up ZSH"

	export NEW_USER="root"
	source "$DOTFILES/bin/user-config.sh"
	unset NEW_USER
fi

# Make sure everything is up to date
# #####################################
doing "Updating everything..."
apt update -y
apt upgrade -y

# DigitalOcean
# #####################################
# Metrics
if [[ ! -d "/opt/digitalocean/do-agent" ]]; then
	doing "Upgrading DigitalOceans Metrics Agent..."
	# Uninstall the legacy metrics agent.
	apt-get purge do-agent

	# Install the current metrics agent.
	curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash
fi

# Doctl (DigitalOcean's Command-Line tool)
doing "Installing DigitalOcean's cli [doctl]"
snap install doctl

# Firewall
# #####################################
doing "Configuring Firewall to allow SSH connections"
ufw allow OpenSSH

# Enable the firewall
ufw enable
# Open port for Webhook
ufw allow 9000/tcp

# Create Admin-User
# #####################################
echo "❓ What do you want the admin username to be? [not 'root' user]"
read -r NEW_USER

doing "Creating your admin user..."

# Create user
adduser "$NEW_USER"

# Give user admin privileges
usermod -aG sudo "$NEW_USER"

# Copy Dotfiles to new user and assign permissions
cp -r "$DOTFILES" "/home/$NEW_USER"
sudo chown -R "$NEW_USER":"$NEW_USER" "/home/$NEW_USER/_dotfiles"
sudo chmod -R 755 "/home/$NEW_USER/_dotfiles"

# Switch to new user
# #####################################
doing "Switching to the user '$NEW_USER' to finish the install."
echo "Once you've changed to that account, finish the install"
echo "by running [ source ~/_dotfiles/bin/install-finish.sh ]"

su - "$NEW_USER"
