#!/bin/bash

if [[ ! "$DOMAIN" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN
fi

echo "#####################################"
echo "Use this for completing the SSL cert:"
echo "Email: [admin@workwithizzi.com]"
# echo "1 - Agree           : [A]"
# echo "2 - No              : [N]"
echo "Redirect traffic: [2]"
echo "#####################################"
sudo certbot --nginx -d "$DOMAIN" -d "www.$DOMAIN"
