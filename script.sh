#!/bin/bash

# Define variables
LOCAL_USERNAME="ansible"
REMOTE_USERNAME="administrator"
REMOTE_SERVERS_FILE="remote_servers.txt"

# Check if the remote servers file exists
if [ ! -f "$REMOTE_SERVERS_FILE" ]; then
    echo "Remote servers file $REMOTE_SERVERS_FILE not found."
    exit 1
fi

# Create local user
sudo useradd -m $LOCAL_USERNAME
sudo mkdir -p /home/ansible/.ssh/

# Generate SSH key pair (Ed25519) for local user
sudo ssh-keygen -t ed25519 -f "/home/$LOCAL_USERNAME/.ssh/id_ed25519" -N ""
sudo cp "/home/$LOCAL_USERNAME/.ssh/id_ed25519" "/home/administrator/certificates"

# Copy the public key to remote servers
while IFS= read -r SERVER; do
    sudo ssh-copy-id -i /home/$LOCAL_USERNAME/.ssh/id_ed25519.pub $REMOTE_USERNAME@$SERVER
done < "$REMOTE_SERVERS_FILE"

echo "Local user $LOCAL_USERNAME created and SSH keys (Ed25519) copied to remote servers."

