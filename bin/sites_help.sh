#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
# #####################################

export BIN=${0:a:h}

source "$BIN/utils/colors.sh"

# ##################

echo "${BPurple}<sites> : Shortcuts for managing sites${Reset}"
echo "commands:"
echo "- create    : Create and configure a new site by following prompts."
echo "- remove    : Completely remove a site (and all related files)"
echo "  - options:"
echo "    - [example.com] Domain name of the site to remove."
echo "- list      : Prints list of all active sites."
echo "- go        : Takes you to a directory related to a site"
echo "  - options:"
echo "    - info         : Base directory for all info files"
echo "    - scripts      : Base directory for all deploy scripts"
echo "    - hooks        : Base directory for all webhooks"
echo "    - [example.com]: Root directory for example.com"
echo "    - no-option    : Base directory for all sites"
echo "- disable   : Disable a site in NGINX so that it's not accessible online"
echo "  - options:"
echo "    - [example.com] Domain name of the site."
echo "- enable    : Enable a site in NGINX"
echo "  - options:"
echo "    - [example.com] Domain name of the site."
echo "- info      : Prints the info file for a specific site"
echo "  - options:"
echo "    - [example.com] Domain name of the site."
echo "- rename    : Rename a site. Including file names, configs, hooks, etc"
echo "  - option 1:"
echo "    - [old-name.com] original domain name of the site."
echo "  - option 2:"
echo "    - [new-name.com] New domain name of the site."
echo "- defaults  : Configures default settings to be used when creating a site"
echo "  - options:"
echo "    - create : Create the defaults if they don't exist"
echo "    - update : Update the current defaults"
echo "    - view   : View the current defaults"
echo "- no-command: Prints this help info"
