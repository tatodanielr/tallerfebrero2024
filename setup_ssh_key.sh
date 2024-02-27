#!/bin/bash

# File containing the list of servers
SERVERS_FILE="servers.txt"

# Check if the servers file exists and is readable
if [ ! -f "$SERVERS_FILE" ]; then
    echo "The servers file '$SERVERS_FILE' does not exist or is not readable."
    exit 1
fi

# SSH User
USER="administrator"

# Prompt user for SSH password (it will be used for all SSH connections)
#read -s -p "Enter SSH password for $USER: " SSH_PASSWORD
#echo

# Path to the local SSH public key
SSH_PUBLIC_KEY="$HOME/.ssh/id_ed25519.pub"

# Check if the local SSH public key exists
if [ ! -f "$SSH_PUBLIC_KEY" ]; then
    echo "Local SSH public key '$SSH_PUBLIC_KEY' does not exist."
    echo "Generate SSH key pair first using 'ssh-keygen -t ed25519' command."
    exit 1
fi

# Read the list of servers from the file
mapfile -t SERVERS < "$SERVERS_FILE"

# Generate SSH Ed25519 key pair with a comment
ssh-keygen -t ed25519 -C "SSH Key for server access"

# Copy the public key to remote servers
for HOST in "${SERVERS[@]}"; do
    echo "Copying public key to $HOST..."
    ssh-copy-id -i ~/.ssh/id_ed25519.pub $USER@$HOST
done

echo "Process completed."