#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
# #####################################

export BIN=${0:a:h}

source "$BIN/utils/colors.sh"

# ##################

echo "${BPurple}<hooks> : Shortcuts for working with Webhook${Reset}"
echo "commands:"
echo "combine: Compiles individual hooks files"
echo "         into \"master\" hooks file."
echo "create : Creates the domain's hook file and adds it"
echo "         to the \"master\" hooks file."
echo "remove : Removes the domain's hook file and removes"
echo "         it from the \"master\" hooks file."
echo "stop   : Stops the webhook process using <kill> command"
echo "start  : Starts webhook with hooks in the \"master\" hooks file."
echo "restart: Stops. Then starts webhook. Obviously."
echo ""
echo "options:"
echo "[create|remove] : You can also pass the domain"
echo "                  name as a second argument"
echo "[start|restart] : Use [-v] as a second argument to start"
echo "                  webhook in 'verbose' mode."
