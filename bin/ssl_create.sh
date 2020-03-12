#!/bin/bash
# shellcheck disable=SC1090,SC2034
#
# Args
# - 1: domain
# #####################################

# export BIN=${0:a:h}

# ##################
# Get Domain
if [[ -z "$1" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN
else
	DOMAIN="$1"
fi

# ##################
# Check domain for SSL
if [[ -d "/etc/letsencrypt/live/$DOMAIN" ]]; then
	echo "Looks like there's already a cert for this domain."
	echo "To view all certificates, run:"
	echo "[ certbot certificates ]"
	echo "If you want to remove a certificate, then run:"
	echo "[ ssl delete ] or [ ssl delete $DOMAIN ]"
else

	echo "#####################################"
	echo "Use this for completing the SSL cert:"
	echo "Email: [admin@workwithizzi.com]"
	# echo "1 - Agree           : [A]"
	# echo "2 - No              : [N]"
	echo "Redirect traffic: [2]"
	echo "#####################################"
	sudo certbot --nginx -d "$DOMAIN" -d "www.$DOMAIN"
fi
