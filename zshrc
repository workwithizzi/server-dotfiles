# shellcheck shell=sh
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Default version of Node to use
export NODEPATH=/opt/plesk/node/10/bin

# Add Plesk's node to the PATH
export PATH=$NODEPATH:$PATH

# Add options for the other versions of node
alias node8=/opt/plesk/node/8/bin/node
alias npm8=/opt/plesk/node/8/bin/npm

alias node10=/opt/plesk/node/10/bin/node
alias npm10=/opt/plesk/node/10/bin/npm

alias node12=/opt/plesk/node/12/bin/node
alias npm12=/opt/plesk/node/12/bin/npm


# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load
ZSH_THEME="simple"


# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
	git
	extract
	zsh-syntax-highlighting
	zsh-autosuggestions
	)

source $ZSH/oh-my-zsh.sh


# Use Case Insensitive Globbing
setopt NO_CASE_GLOB

# Auto CD to path. Removes the need for `cd` in the command
setopt AUTO_CD

# Save shell history upon exiting shell
HISTFILE=$HOME/.zsh_history

# Add timestamp (in unix epoch time) to shell history
setopt EXTENDED_HISTORY

# Only save 3000 commands in shell history
SAVEHIST=3000

# Only save 1000 commands in current shell session
HISTSIZE=1000

# Share shell history across multiple zsh sessions
setopt SHARE_HISTORY
# Append shell history instead of overwriting it
setopt APPEND_HISTORY

# Add commands to history file as they are entered, not at shell exit
setopt INC_APPEND_HISTORY

# Remove blank lines from shell history file
setopt HIST_REDUCE_BLANKS

# Verify the history option command (`!!`) before running it
setopt HIST_VERIFY

# Let zsh offer suggestions when I enter a mistake
# [nyae]
#   n: execute command as typed
#   y: accept and execute suggested command
#   a: abort command and do nothing
#   e: return to the prompt to continue editing
setopt CORRECT
setopt CORRECT_ALL


# #####################################
# Completion
# #####################################

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# Initialize zsh completion system. @see: t.ly/7J6B2
autoload -Uz compinit && compinit


# #####################################
# Shortcuts
# #####################################

# Clear terminal window
alias c="clear"

# Reload Shell
alias reshell="source ~/.zshrc"

# Open ZSH Config
alias openzsh="nano ~/.zshrc"

# Get the date in `YYMMDD` format
shortdate() {
	date +"%y%m%d"
}

# Get the time
shorttime() {
	date +"%H%M%S"
}

# Copy the current directory path to the clipboard
alias copypath="pwd|pbcopy"


# #####################################
# Files & Navigation
# #####################################

# Go to home directory
alias home="cd ~"

# Go to Grandparent Directory
alias ...="cd ../../"

# List files in dir
# A - include hidden files
# F - Include "/" for folders
# G - use Color
alias lsa="ls -AFG"

# Do the stuff above and:
# sk - print size in kilobytes
# S  - Sort by size
# r  - Reverse the sort so largest is on top
alias lss="ls -AFGskSr"

# Make a directory and cd into it
mkdircd() { mkdir "$*" && cd "$*" || return; }


# #####################################
# Utilities
# #####################################

# Go to directory where sites are and list them
alias list-sites="cd /var/www/vhosts && ls -d */"

# Remove the Plesk "intro" banner
alias hush_plesk="rm -rf /etc/motd && touch /etc/motd"