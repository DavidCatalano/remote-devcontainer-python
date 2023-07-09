#!/bin/bash

# Load the .env file
source .env

# Convert DEV_NAME to lower case
DEV_NAME_LOWER=$(echo "$DEV_NAME" | tr '[:upper:]' '[:lower:]')
PROJECT_NAME_LOWER=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')

# Prompt the user before proceeding
read -p "This action will delete all data in the volume. Continue? [N/y] " answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo "Aborting..."
    exit 0
fi

# Use the variables from the .env file
echo "Stopping ${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER} container..."
docker -H ssh://$DEV_NAME@$DEV_HOST stop "${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER}"
echo "Removing ${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER} container..."
docker -H ssh://$DEV_NAME@$DEV_HOST rm "${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER}"
echo "Removing ${PROJECT_NAME_LOWER}_${DEV_NAME_LOWER} volume..."
docker -H ssh://$DEV_NAME@$DEV_HOST volume rm "${PROJECT_NAME_LOWER}_${DEV_NAME_LOWER}"
echo "Complete!"
