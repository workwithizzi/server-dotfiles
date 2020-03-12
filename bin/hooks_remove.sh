#!/bin/bash
# shellcheck disable=SC1090,SC2034

# Get Info
if [[ ! "$1" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN
else
	DOMAIN="$1"
fi

FNAME="${DOMAIN//./_}"

# #####################################

# Remove hook file if it exists
if [[ -f "$HOOKS_PATH/$FNAME.json" ]]; then
	rm "$HOOKS_PATH/$FNAME.json"

else
	echo "Looks like there isn't a hook availble for $DOMAIN."
fi
