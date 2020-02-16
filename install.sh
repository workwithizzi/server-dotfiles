#!/bin/bash

echo "Removing the Plesk intro banner"
echo "If you haven't set up Plesk yet, you will still need to run <sudo plesk login>"
rm -rf /etc/motd
touch /etc/motd


if [[ ! -d "/opt/digitalocean/bin" ]]; then
	echo "Installing the DigitialOcean Monitoring Agent:"
	curl -sSL https://agent.digitalocean.com/install.sh | sh
fi

if [[ ! -d "/opt/digitalocean/do-agent" ]]; then
	echo "Upgrading DigitalOceans Metrics Agent:"
	# Uninstall the legacy metrics agent.
	sudo apt-get purge do-agent

	# Install the current metrics agent.
	curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash
fi

if [[ ! -f "$HOME/.zshrc" ]]; then
	echo "Setting up ZSH"
	# Install ZSH
	sudo apt install zsh

	# Change the default shell of the root user to zsh
	chsh -s /usr/bin/zsh root

	# Install Oh-My-ZSH
	sudo wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

	# Install syntax highlighting
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

	# Install autosuggestions
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

	echo "Logging you out of the server. Log back in for changes to take effect"
	exit
fi