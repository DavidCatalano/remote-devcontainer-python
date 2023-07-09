#!/bin/bash

# Load the .env file
source .env

# Convert PROJECT_NAME and DEV_NAME to lower case
PROJECT_NAME_LOWER=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')
DEV_NAME_LOWER=$(echo "$DEV_NAME" | tr '[:upper:]' '[:lower:]')

echo "Building ${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER} container..."

# Build the Docker image
docker -H ssh://$DEV_NAME@$DEV_HOST build -t ${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER} .

# Run the Docker container. Uses same volume syntax as docker-compose
docker -H ssh://$DEV_NAME@$DEV_HOST run -d \
    --name ${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER} \
    -e DEVCONTAINER=${DEV_ENV} \
    -v ${PROJECT_NAME_LOWER}_${DEV_NAME_LOWER}:/app \
    ${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER}
