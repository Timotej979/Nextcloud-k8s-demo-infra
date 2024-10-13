#!/bin/bash

# Function to show help message
show_help() {
    echo
    echo "Generate RSA key pair and output in JSON format." >&2
    echo
    echo "Usage: $0 key_name passphrase recreate_flag" >&2
    echo
    echo "Arguments:" >&2
    echo "  key_name       Name of the key to be generated" >&2
    echo "  passphrase     Passphrase for the generated key" >&2
    echo "  recreate_flag  0 to use existing keys, 1 to force recreation of SSH keys" >&2
    echo
    echo "Output:" >&2
    echo "  JSON object with private_key and public_key fields" >&2
    echo
    echo "Example:" >&2
    echo "  ./generate_keys my_key my_passphrase 1" >&2
    echo
    echo "Output example:" >&2
    echo '  {' >&2
    echo '    "private_key": "-----BEGIN RSA PRIVATE KEY-----..."' >&2
    echo '    "public_key": "-----BEGIN PUBLIC KEY-----..."' >&2
    echo '  }' >&2
    echo
    echo "Note:" >&2
    echo "  If the private and public keys already exist in the $HOME/.ssh directory," >&2
    echo "  the script will use the existing keys unless recreate_flag is set to 1." >&2
    echo
    exit 0
}

# Check if --help is passed as an argument
if [ "$1" = "--help" ]; then
    show_help
fi

# Check if at least two arguments are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <key_name> <passphrase> <recreate_flag>" >&2
    exit 1
fi

KEY_NAME="$1"
KEY_PATH="$HOME/.ssh/$KEY_NAME"
KEY_PUB_PATH="$KEY_PATH.pub"
PASSPHRASE="$2"
RECREATE="$3"

# Check if the recreate_flag is valid
if [[ "$RECREATE" != 1 && "$RECREATE" != 0 ]]; then
    echo "Error: recreate_flag must be '0' or '1'." >&2
    exit 1
fi

# Check if the SSH directory exists, if not, create it
if [ ! -d "$HOME/.ssh" ]; then
    echo "SSH directory does not exist at $HOME/.ssh. Creating directory." >&2
    mkdir -p "$HOME/.ssh"
    
    # Check for errors during directory creation
    if [ $? -ne 0 ]; then
        echo "Failed to create SSH directory." >&2
        exit 1
    fi
fi

# Initialize variables to hold key contents
PRIVATE_KEY_CONTENT=""
PUBLIC_KEY_CONTENT=""

# Check if the SSH key already exists and recreate flag is not set
if [ -f "$KEY_PATH" ] && [ -f "$KEY_PUB_PATH" ] && [ "$RECREATE" -eq 0 ]; then
    # Use existing keys
    echo "Using existing SSH keys at $KEY_PATH" >&2
    PRIVATE_KEY_CONTENT=$(cat "$KEY_PATH")
    PUBLIC_KEY_CONTENT=$(cat "$KEY_PUB_PATH")

else
    # Remove existing keys if recreate flag is set
    rm -f "$KEY_PATH" "$KEY_PUB_PATH"

    # Generate SSH key with a passphrase
    echo "Generating SSH key at $KEY_PATH" >&2
    ssh-keygen -t ed25519 -f "$KEY_PATH" -N "$PASSPHRASE" -q

    # Check if key generation was successful
    if [ $? -ne 0 ]; then
        echo "SSH key generation failed." >&2
        exit 1
    fi

    # Read the newly generated keys
    PRIVATE_KEY_CONTENT=$(cat "$KEY_PATH")
    PUBLIC_KEY_CONTENT=$(cat "$KEY_PUB_PATH")
fi

# Output keys in JSON format using jq
jq -n \
  --arg private_key "$PRIVATE_KEY_CONTENT" \
  --arg public_key "$PUBLIC_KEY_CONTENT" \
  '{
    private_key: $private_key,
    public_key: $public_key
  }'

# Successful script execution
exit 0
