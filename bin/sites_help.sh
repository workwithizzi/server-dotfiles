#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
# #####################################

export BIN=${0:a:h}

source "$BIN/utils/colors.sh"

# ##################

source "$BIN/sites_create.sh"
source "$BIN/sites_go.sh"
source "$BIN/sites_remove.sh"
source "$BIN/sites_list.sh"
source "$BIN/sites_enable_disable.sh"
source "$BIN/sites_info.sh"
source "$BIN/sites_rename.sh"
source "$BIN/sites_defaults.sh"

# echo "${BPurple}<sites> : Shortcuts for managing sites${Reset}"
cmd_h1 "sites"
cmd_desc "Shortcuts for managing sites"
sites_create_help
sites_remove_help
sites_list_help
sites_go_help
sites_enable_help
sites_disable_help
sites_info_help
sites_rename_help
sites_defaults_help
