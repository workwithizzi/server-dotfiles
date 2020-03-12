#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
# #####################################

# export BIN=${0:a:h}

# ##################

cmd_h1 "sites"
cmd_desc "Shortcuts for managing sites"

source "$BIN/sites_create.sh"
sites_create_help

source "$BIN/sites_remove.sh"
sites_remove_help

source "$BIN/sites_rename.sh"
sites_rename_help

source "$BIN/sites_list.sh"
sites_list_help

source "$BIN/sites_go.sh"
sites_go_help

source "$BIN/sites_enable_disable.sh"
sites_enable_help
sites_disable_help

source "$BIN/sites_info.sh"
sites_info_help

source "$BIN/sites_defaults.sh"
sites_defaults_help
