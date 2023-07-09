#!/bin/bash

# Load the .env file
source .env

# Ensure lower case
DEV_NAME_LOWER=$(echo "$DEV_NAME" | tr '[:upper:]' '[:lower:]')
PROJECT_NAME_LOWER=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')

# Define the source file path
SOURCE_FILE="container_config.json"

# Define the target file path
TARGET_FILE="${VSCODE_CONTAINER_CONFIG_PATH}/${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER}.json"

# Install container configuration in VS Code
echo "Copying: \"$SOURCE_FILE\" to the VS Code container configuration in your home directory as \"${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER}.json\""
echo "Opening a remote container in VS Code with the name: \"${PROJECT_NAME_LOWER}-${DEV_NAME_LOWER}\" will use this configuration"
cp "$SOURCE_FILE" "$TARGET_FILE"
