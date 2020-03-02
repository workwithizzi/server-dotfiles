#!/usr/bin/env bash

# SSH Keys
# #####################################

# (on your local machine) Add public keys to .ssh
pbcopy > ~/.ssh/id_rsa.pub

# Then SSH into the new server:

# Create directory if it doesn't exist
mkdir -p ~/.ssh

# Create and open the authorized_keys fle
nano ~/.ssh/authorized_keys

# Make sure permissions and ownership of the files are correct
chmod -R go= ~/.ssh
chown -R $USER:$USER ~/.ssh


# Copy SSH keys to new user
rsync --archive --chown=$ADMIN_USER:$ADMIN_USER ~/.ssh /home/$ADMIN_USER
