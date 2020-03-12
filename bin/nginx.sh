#!/bin/bash
# shellcheck disable=SC1090,SC2034,SC2154
# #####################################

source "$BIN/utils/colors.sh"

# ##################
# Help Function
_nginx_help() {
	cmd_h1 "_nginx"
	cmd_desc "Shortcust for withing with NGINX"
	cmd_desc "More Info: https://t.ly/8p2pN"

	cmd_h2 "status"
	cmd_h2_desc "Show current status of NGINX services"
	cmd_h2 "restart"
	cmd_h2_desc "Stop and then start NGINX services"
	cmd_h2 "reload"
	cmd_h2_desc "Reload NGINX without dropping connections"
	cmd_h2 "check"
	cmd_h2_desc "Check Nginx files for syntax errors"
}

# ##################

_nginx() {
	if [[ "$2" = "help" ]]; then
		_nginx_help

	# If not help, do the things
	else
		if [[ "$1" = "status" ]]; then
			sudo systemctl status nginx

		elif [[ "$1" = "stop" ]]; then
			sudo systemctl stop nginx

		elif [[ "$1" = "start" ]]; then
			sudo systemctl start nginx

		elif [[ "$1" = "restart" ]]; then
			sudo systemctl restart nginx

		elif [[ "$1" = "reload" ]]; then
			sudo systemctl reload nginx

		elif [[ "$1" = "check" ]]; then
			sudo nginx -t

		# If all else fails, send help
		else
			_nginx_help
		fi

	fi
}
