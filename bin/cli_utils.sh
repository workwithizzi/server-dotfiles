#!/bin/bash
# shellcheck disable=SC1090,SC2034

# export current_file=${0:a}
export BIN=${0:a:h}

source "$BIN/utils/colors.sh"

# Change owner and permissions
assign_dir() {
	sudo chown -R "$1":"$1" "$2"
	sudo chmod -R 755 "$2"
}

assign_file() {
	sudo chown "$1":"$1" "$2"
	sudo chmod 755 "$2"
}

# See what ports are active
see_ports() {
	sudo lsof -i -P -n | grep LISTEN
}

# Get the pid of a something on a specific port
see_port_pid() {
	lsof -t -i:"$1"
}

# Stop something running on a specific port
stop_port() {
	kill "$(lsof -t -i:$1)"
}

# Block an IP address
ip_block() {
	sudo ufw deny from "$1"
}

# Allow an IP address
ip_allows() {
	sudo ufw allow from "$1"
}

_nginx() {
	if [[ "$1" = "status" ]]; then
		# Make sure NGINX is running
		sudo systemctl status nginx

	elif [[ "$1" = "stop" ]]; then
		# Stop web server
		sudo systemctl stop nginx

	elif [[ "$1" = "start" ]]; then
		# start the web server when it is stopped
		sudo systemctl start nginx

	elif [[ "$1" = "restart" ]]; then
		# To stop and then start the service again
		sudo systemctl restart nginx

	elif [[ "$1" = "reload" ]]; then
		# For simple config changes, Nginx can
		# often reload without dropping connections.
		sudo systemctl reload nginx

	elif [[ "$1" = "check" ]]; then
		# Check Nginx files for syntax errors:
		sudo nginx -t

	else
		echo "NGINX Shortcut commands. Options:"
		echo "status"
		echo "stop"
		echo "start"
		echo "restart"
		echo "reload"
		echo "check"
		echo "More Info: https://t.ly/8p2pN"
	fi
}

ssl() {
	if [[ "$1" = "add" ]]; then
		if [[ "$2" ]]; then
			DOMAIN="$2"
		fi
		source "$BIN/add_site_ssl.sh"
		unset DOMAIN

	elif [[ "$1" = "renew" ]]; then
		if [[ "$2" = "dry" ]]; then
			# Test to make sure auto-renewal is working
			sudo certbot renew --dry-run
		else
			# To non-interactively renew *all* SSL certificates:
			sudo certbot renew
		fi
	elif [[ "$1" = "delete" ]]; then
		if [[ "$2" ]]; then
			sudo certbot delete --cert-name "$2"
		else
			# Show list for deletion
			sudo certbot delete
		fi
	else
		echo "_ssl options:"
		echo "renew:     renews all certificates"
		echo "renew dry: tests to see if auto-renewal is working"
		echo "delete:    shows list of certificates to delete"
		echo "delete example.com: Deletes the certificate for 'example.com'"
	fi
}

# Create and configure a new website
add_site() {
	source "$BIN/add_site.sh"
}

source "$BIN/sites.sh"
source "$BIN/hooks.sh"
