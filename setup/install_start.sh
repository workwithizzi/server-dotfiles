#!/bin/bash
# shellcheck disable=SC1090,SC2034

doing() { echo "🚀  ""$*"; }

export DOTFILES="$HOME/_dotfiles"
export SETUP_D="$DOTFILES/setup"

# 'root' Environment
# #####################################
source "$SETUP_D/user_config.sh"

# #####################################
doing "Updating all the things..."
apt update -y
apt upgrade -y

# #####################################
# DigitalOcean
# Metrics
if [[ ! -d "/opt/digitalocean/do-agent" ]]; then
	doing "Upgrading DigitalOceans Metrics Agent..."
	# Uninstall the legacy metrics agent.
	apt-get purge do-agent

	# Install the current metrics agent.
	curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash
fi

# Doctl (DigitalOcean's Command-Line tool)
doing "Installing [doctl] -- DigitalOcean's cli..."
snap install doctl

# #####################################
# Firewall
doing "Configuring Firewall to allow SSH connections"
ufw allow OpenSSH
# Enable the firewall
ufw enable
# Open port for Webhook
ufw allow 9000/tcp

# Create Admin-User
# #####################################
echo "❓ What do you want the admin username to be? [not 'root']"
read -r ADMIN_USER

doing "Creating your admin user..."

# Create user
adduser "$ADMIN_USER"

# Give user admin privileges
usermod -aG sudo "$ADMIN_USER"

# Copy Dotfiles to new user and assign permissions
cp -r "$DOTFILES" "/home/$ADMIN_USER"
sudo chown -R "$ADMIN_USER":"$ADMIN_USER" "/home/$ADMIN_USER/_dotfiles"
sudo chmod -R 755 "/home/$ADMIN_USER/_dotfiles"

# Switch to new user
# #####################################
doing "Switching to '$ADMIN_USER' to finish the install..."
echo "Once you're in that account, finish the install"
echo "by running [ source \$HOME/_dotfiles/setup/install_finish.sh ]"

su - "$ADMIN_USER"
