#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
#
# Args
# - 1: domain
# #####################################

source "$BIN/utils/colors.sh"

# ##################
# Helper Function
ssl_create_help() {
	cmd_h2 "ssl create"
	cmd_h2_desc "Uses certbot to create your SSL certificate"
	cmd_h2_opt_title "options:"
	cmd_h2_opt "[example.com]:" "Domain to use for the certificate"
}

# ##################
# Task Function
ssl_create_cmd() {
	# ##################
	# Get Domain
	if [[ -z "$1" ]]; then
		echo "${On_Purple}Please re-enter your domain name? [example.com]${Reset}"
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

		echo "${On_Purple}#####################################"
		echo "Use this for completing the SSL cert:"
		echo "Email: [admin@workwithizzi.com]"
		# echo "1 - Agree           : [A]"
		# echo "2 - No              : [N]"
		echo "Redirect traffic: [2]"
		echo "#####################################${Reset}"
		sudo certbot --nginx -d "$DOMAIN" -d "www.$DOMAIN"
	fi
}

# ##################
# Final Output Command
ssl_create() {
	if [[ "$1" = "help" ]]; then
		ssl_create_help
	else
		ssl_create_cmd "$1"
	fi
}
