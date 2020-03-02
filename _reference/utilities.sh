#!/usr/bin/env bash

# Utilities

# # See what ports are active
# sudo lsof -i -P -n | grep LISTEN

# # Get the pid of a something on a specific port
# lsof -t -i:"$PORT"
# # Stop something running on a specific port
# kill "$(lsof -t -i:$PORT)"
# Or, by using the pid
kill -9 "$PID"

# Firewall
# https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands
# #####################################
# See what profiles (apps) have been registered with our firewall
ufw app list

# See if ssh connections are still allowed
ufw status

# Block an IP address
sudo ufw deny from $IP_ADDRESS

# Allow an IP address
sudo ufw allow from $IP_ADDRESS

# Allow SSH
sudo ufw allow ssh

# NGINX
# Info: https://t.ly/8p2pN

# # Make sure NGINX is running
# sudo systemctl status nginx

# # Stop web server
# sudo systemctl stop nginx

# # start the web server when it is stopped
# sudo systemctl start nginx

# # To stop and then start the service again
# sudo systemctl restart nginx

# # If you are simply making configuration changes, Nginx can often reload without dropping connections. To do this, type:
# sudo systemctl reload nginx

# # test to make sure that there are no syntax errors in any of your Nginx files:
# sudo nginx -t

# SSL
# To non-interactively renew *all* SSL certificates:
# sudo certbot renew

# # Test to make sure auto-renewal is working
# sudo certbot renew --dry-run

# See which version of Ubuntu is installed
sudo cat /etc/os-release

# DigitalOcean
# # #####################################
# Full reference: https://tinyurl.com/hablty4

# List all ssh-keys on the account
doctl compute ssh-key list

# List all available images and snapshots
doctl compute image list

# Droplet Info #######
# List All Droplets
doctl compute droplet list

# Display history of actions for a specific droplet
doctl compute droplet actions "$DROPLET_ID"

# List backups for a specific Droplet
doctl compute droplet backups "$DROPLET_ID"

# List snapshots for a specific Droplet
doctl compute droplet snapshots "$DROPLET_ID"

# Deleting a specific droplet
doctl compute droplet delete "$DROPLET_ID"

# Taking action on a droplet ######

# Disable backups
doctl compute droplet-action disable-backups "$DROPLET_ID"

# reboot
doctl compute droplet-action reboot "$DROPLET_ID"

# turn off and back on again
doctl compute droplet-action power-cycle "$DROPLET_ID"

# shutdown
doctl compute droplet-action shutdown "$DROPLET_ID"

# Power on a Droplet. The Droplet must be powered off.
doctl compute droplet-action power-on "$DROPLET_ID"

# Take a snapshot of a Droplet.
doctl compute droplet-action snapshot "$DROPLET_ID" --snapshot-name "$SNAPSHOT_NAME"

# Working with Domains ########

# List domains
doctl compute domain list

# Create domain with default records
doctl compute domain create "$DOMAIN" --ip-address "$DROPLET_IP"

# Get a domain record
doctl compute domain get "$DOMAIN"

# Delete a domain
doctl compute domain delete "$DOMAIN"

# Managing Domain Records ####

# List records for given domain.
doctl compute domain records list "$DOMAIN"

# Create an record for domain
doctl compute domain records create "$DOMAIN" --record-type "$RECORD_TYPE"

# Delete record by numeric ID
doctl compute domain records delete "$DOMAIN" "$RECORD_ID"

# Update record by numeric ID
doctl compute domain records update "$DOMAIN" --record-id "$RECORD_ID"

182208713
