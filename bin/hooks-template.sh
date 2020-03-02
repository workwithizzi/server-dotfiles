#!/bin/bash

# TODO: Add a way to create a unique secret for the deploy
DEPLOY_SECRET="TestSecret"
{
  echo "["
  echo "  {"
  echo "    \"id\": \"$DOMAIN\","
  echo "    \"execute-command\": \"/var/www/$DOMAIN/deploy.sh\","
  echo "    \"command-working-directory\": \"/var/www/$DOMAIN/live/\","
  echo "    \"response-message\": \"Executing script...\","
  echo "    \"trigger-rule\": {"
  echo "      \"match\": {"
  echo "        \"type\": \"payload-hash-sha1\","
  echo "        \"secret\": \"$DEPLOY_SECRET\","
  echo "        \"parameter\": {"
  echo "          \"source\": \"header\","
  echo "          \"name\": \"X-Hub-Signature\""
  echo "        }"
  echo "      }"
  echo "    }"
  echo "  }"
  echo "]"
} >>"/var/www/$DOMAIN/hooks.json"
