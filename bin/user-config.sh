#!/usr/bin/env bash

doing() { echo "🚀  ""$*"; }
# #####################################

if [[ ! $NEW_USER ]]; then
	echo "❓ What do you want the admin username to be? [not 'root' user]"
	read -r NEW_USER
fi

# Create config directory for doctl
if [[ ! -d "$HOME/.config" ]]; then
	mkdir "$HOME/.config"
fi

# TODO: git clone dotfiles

# ZSH
# #####################################

# Install ZSH
sudo apt install zsh -y

# Change the default shell of the user to zsh
doing "Changing the default shell for $NEW_USER to ZSH"
sudo chsh -s /usr/bin/zsh "$NEW_USER"

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
	doing "Installing oh-my-zsh"
	sudo wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
fi

doing "Installing syntax highlighting"
if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins" ]]; then
	mkdir -p "$HOME/.oh-my-zsh/custom/plugins"
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

doing "Installing auto-suggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

doning "Setting up ZSH theme"
if [[ ! -d "$HOME/.oh-my-zsh/custom/themes" ]]; then
	mkdir -p "$HOME/.oh-my-zsh/custom/themes"
fi
cp "$DOTFILES/bin/simple.zsh-theme" "$HOME/.oh-my-zsh/custom/themes"

doing "Setting up zhrc"
rm -rf "$HOME/.zshrc"

echo "export ZDOTDIR=$DOTFILES" >>"$HOME/.zshenv"

ln -s "$DOTFILES/.zshrc" "$HOME"
