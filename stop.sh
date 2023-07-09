#!/bin/bash

# Load the .env file
source .env

# Convert PROJECT_NAME and DEV_NAME to lower case
PROJECT_NAME_LOWER=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')
DEV_NAME_LOWER=$(echo "$DEV_NAME" | tr '[:upper:]' '[:lower:]')

echo "Stopping ${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER} container..."
docker -H ssh://$DEV_NAME@$DEV_HOST stop ${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER}