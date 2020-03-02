#!/bin/bash

if [[ ! "$DOMAIN" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN
fi

if [[ ! -d "/var/www/$DOMAIN/" ]]; then
	sudo mkdir -p "/var/www/$DOMAIN/"
fi

if [[ ! "$BRANCH" ]]; then
	echo "What branch do you want to use? [master]"
	read -r BRANCH
fi

{
	echo "#!/bin/bash"
	echo "git fetch --all"
	echo "git checkout --force \"origin/$BRANCH\""
} >>"/var/www/$DOMAIN/deploy.sh"
