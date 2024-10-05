#!/bin/bash

# Check if arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <key_name> <passphrase>"
    exit 1
fi

KEY_NAME="$1"
KEY_PATH="$HOME/.ssh/$KEY_NAME"
KEY_PUB_PATH="$KEY_PATH.pub"
PASSPHRASE="$2"

# Check if the SSH key already exists
if [ -f "$KEY_PATH" ]; then
    echo "SSH key already exists at $KEY_PATH. Skipping key generation."
    exit 0
fi

# Generate SSH key with a passphrase
echo "Generating SSH key at $KEY_PATH"
ssh-keygen -t rsa -b 4096 -f "$KEY_PATH" -N "$PASSPHRASE"

# Check if key generation was successful
if [ $? -ne 0 ]; then
    echo "SSH key generation failed."
    exit 1
fi

echo "SSH key generated successfully."
