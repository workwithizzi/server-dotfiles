#!/bin/bash
# shellcheck disable=SC1090,SC2034
# #####################################

export BIN=${0:a:h}

# ##################

# Get Domain
if [[ -z "$1" ]]; then
	echo "What site do you want to remove? [example.com]"
	read -r DOMAIN
else
	DOMAIN="$1"
fi

# Filename
FNAME="${DOMAIN//./_}"

# ##################

# Get info if file exists
if [[ -f "$INFO_PATH/$FNAME" ]]; then
	cat "$INFO_PATH/$FNAME"
else
	echo "Something went wrong. We can't find an info for $DOMAIN"
	echo "Try [ sites list ] to view all available sites"
fi

# #####################################

unset DOMAIN FNAME
