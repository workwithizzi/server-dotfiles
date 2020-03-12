#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
# #####################################

source "$BIN/utils/colors.sh"

# ##################

ssl() {
	if [[ "$1" = "create" || "$1" = "delete" ]] && [[ ! "$2" ]]; then
		echo "Domain Name? [example.com]"
		read -r DOMAIN
	else
		DOMAIN="$2"
	fi

	if [[ "$1" = "create" ]]; then
		source "$BIN/ssl_create.sh"
		ssl_create "$DOMAIN"

	elif [[ "$1" = "renew" ]]; then
		if [[ "$2" = "dry" ]]; then
			# Test to make sure auto-renewal is working
			sudo certbot renew --dry-run
		else
			# To non-interactively renew *all* SSL certificates:
			sudo certbot renew
		fi

	elif [[ "$1" = "delete" ]]; then
		if [[ -z "$DOMAIN" ]]; then
			sudo certbot delete --cert-name "$DOMAIN"
		else
			# Show list for deletion
			sudo certbot delete
		fi

	else
		cmd_h1 "ssl"
		cmd_desc "Shortcuts for working with certbot and SSL certificates."

		source "$BIN/ssl_create.sh"
		ssl_create_help

		cmd_h2 "renew"
		cmd_h2_desc "Renews all certificates"
		cmd_h2_opt_title "options:"
		cmd_h2_opt "dry:" "tests to see if auto-renewal is working"

		cmd_h2 "delete"
		cmd_h2_desc "Deletes a specific certificate"
		cmd_h2_opt_title "options:"
		cmd_h2_opt "[empty]:" "Shows list of all certificates to choose from"
		cmd_h2_opt "[example.com]:" "Domain to delete cert for."
	fi
}
