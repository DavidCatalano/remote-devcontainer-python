#!/bin/bash

# Load the .env file
source .env

# Test the remote server for permissions
echo "Testing host: \"$DEV_HOST\" with user: \"$DEV_NAME\""
docker -H ssh://$DEV_NAME@$DEV_HOST run hello-world
