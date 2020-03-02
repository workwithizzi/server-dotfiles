#! /usr/bin/zsh

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

_ssl() {
	if [[ "$1" = "renew" ]]; then
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

sites() {
	AVAILABLE_DIR="/etc/nginx/sites-available"
	ENABLED_DIR="/etc/nginx/sites-enabled"

	# Option - list
	if [[ "$1" = "list" ]]; then
		if [[ "$2" = "available" ]]; then
			echo "Available Sites:"
			ls "$AVAILABLE_DIR"
		else
			echo "Enabled Sites:"
			ls "$ENABLED_DIR"
		fi

	# Option - cd
	elif [[ "$1" = "cd" ]]; then
		cd "/var/www/$2"

	# Option - enable
	elif [[ "$1" = "enable" ]]; then
		if [ ! -f "$ENABLED_DIR/$2" ] && [ -f "$AVAILABLE_DIR/$2" ]; then
			sudo ln -s "$AVAILABLE_DIR/$2" "$ENABLED_DIR"
			_nginx reload
			_nginx check
		else
			echo "Something went wrong."
			echo "try [sites list] or [sites list available]"
		fi

	# Option - disable
	elif [[ "$1" = "disable" ]]; then

		# Make sure site is enabled
		if [ ! -f "$ENABLED_DIR/$2" ]; then
			sudo rm "$ENABLED_DIR/$2"
			_nginx reload
			_nginx check
		else
			echo "That site is already disabled."
			echo "try [sites list] or [sites list available]"
		fi

	# Option - burn
	elif [ "$1" = "burn" ]; then
		if [ -f "$ENABLED_DIR/$2" ]; then
			sudo rm "$ENABLED_DIR/$2"
		fi
		if [ -f "$AVAILABLE_DIR/$2" ]; then
			sudo rm "$AVAILABLE_DIR/$2"
		fi
		_nginx reload
		_nginx check

	else

		echo "sites options:"
		echo "list            : List all enabled/active websites"
		echo "list available  : List all available websites"
		echo "cd              : cd into 'www/' directory"
		echo "cd <site>       : cd into that site's base directory"
		echo "enable <site>   : Enable a site"
		echo "disable <site>  : Disable a site"
	fi
}
