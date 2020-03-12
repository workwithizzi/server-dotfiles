#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

doing() { echo "🚀  ""$*"; }

export DOTFILES="$HOME/_dotfiles"
export SETUP_D="$DOTFILES/setup"

# #####################################

doing "Configuring shell environment for [$USER]"

cd "$HOME" || return

# Create config directory for doctl
if [[ ! -d "$HOME/.config" ]]; then
	mkdir "$HOME/.config"
fi

# ZSH
# #####################################

if [[ ! -f "$HOME/.zshrc" ]]; then
	doing "Setting up ZSH..."

	# Install ZSH
	sudo apt install zsh -y

	# #####################################
	doing "Changing the default shell for $USER to ZSH..."
	sudo chsh -s /usr/bin/zsh "$USER"

	# #####################################
	doing "Installing oh-my-zsh..."
	if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
		sudo wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
	fi
	if [[ ! -d "$HOME/.oh-my-zsh/custom/themes" ]]; then
		mkdir -p "$HOME/.oh-my-zsh/custom/themes"
	fi
	if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins" ]]; then
		mkdir -p "$HOME/.oh-my-zsh/custom/plugins"
	fi

	# #####################################
	doing "Adding Syntax Highlighting..."
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

	# #####################################
	doing "Installing auto-suggestions..."
	git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

	# #####################################
	doning "Setting up ZSH theme/prompt..."
	cp "$SETUP_D/simple.zsh-theme" "$HOME/.oh-my-zsh/custom/themes"

	# #####################################
	doing "Setting up zhrc..."
	rm -rf "$HOME/.zshrc"

	echo "export ZDOTDIR=$DOTFILES" >>"$HOME/.zshenv"

	ln -s "$DOTFILES/.zshrc" "$HOME"

	# #####################################
	source "$HOME/.zshrc"

fi
