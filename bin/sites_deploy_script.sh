#!/bin/bash
# shellcheck disable=SC1090,SC2034
# Args
# - 1: domain
# - 2: owner
# - 3: branch
# #####################################

export BIN=${0:a:h}

# Get Defaults
[[ -f "$HOME/.env" ]] && source "$HOME/.env"

# Make scripts dir
if [[ ! -d "$SCRIPTS_PATH" ]]; then
	sudo mkdir -p "$SCRIPTS_PATH"
fi

# ##################
# Get Domain
if [[ -z "$1" ]]; then
	echo "Domain Name? [example.com]"
	read -r DOMAIN
else
	DOMAIN="$1"
fi
# Filename
FNAME="${DOMAIN//./_}"

# Make sure the site doesn't already exist
source "$BIN/check_domain_exists.sh" "$DOMAIN"

# ##################
# Get Owner
if [[ -z "$2" ]]; then
	echo "Associated username? [Default = $ENV_SITE_OWNER]"
	read -r OWNER
else
	OWNER="$2"
fi
if [[ -z "$OWNER" ]]; then
	OWNER="$ENV_SITE_OWNER"
fi

# ##################
# Get Branch
if [[ -z "$3" ]]; then
	echo "What branch do you want to use? [Default = $ENV_BRANCH]"
	read -r BRANCH
else
	BRANCH="$3"
fi
if [[ -z "$BRANCH" ]]; then
	BRANCH="$ENV_BRANCH"
fi

# #####################################

# Create File
sudo touch "$SCRIPTS_PATH/$FNAME.sh"

{
	echo "#!/bin/bash"
	echo "git fetch --all"
	echo "git checkout --force \"origin/$BRANCH\""
} >>"$SCRIPTS_PATH/$FNAME.sh"

assign_file "$OWNER" "$SCRIPTS_PATH/$FNAME.sh"
