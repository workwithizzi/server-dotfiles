#!/bin/bash
# shellcheck disable=SC1090,SC2034
#
# #####################################

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


source "$BIN/nginx.sh"
source "$BIN/ssl.sh"
source "$BIN/sites.sh"
source "$BIN/hooks.sh"
