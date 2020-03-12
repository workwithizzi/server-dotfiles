#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
# #####################################

source "$BIN/utils/colors.sh"

# ##################

cmd_h1 "hooks"
cmd_desc "Shortcuts for working with Webhook"

cmd_h2 "hooks combine"
cmd_h2_desc "Compiles individual hooks files"
cmd_h2_desc "into \"master\" hooks file."

cmd_h2 "hooks create"
cmd_h2_desc "Creates the domain's hook file and adds it"
cmd_h2_desc "to the \"master\" hooks file."
cmd_h2_opt "[example.com]:" "Domain name to create the hook for"

cmd_h2 "hooks remove"
cmd_h2_desc "Removes the domain's hook file and removes"
cmd_h2_desc "it from the \"master\" hooks file."
cmd_h2_opt "[example.com]:" "Domain name to remove the hook for"

cmd_h2 "hooks stop"
cmd_h2_desc "Stops the webhook process using <kill> command"

cmd_h2 "hooks start"
cmd_h2_desc "Starts webhook with hooks in the \"master\" hooks file."
cmd_h2_opt "-v" "Start Webhook in 'verbose' mode."

cmd_h2 "hooks restart"
cmd_h2_desc "Stops. Then starts webhook. Obviously."
cmd_h2_opt "-v" "Start Webhook in 'verbose' mode."
