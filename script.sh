#!/bin/bash

# Define variables
LOCAL_USERNAME="ansible"
REMOTE_USERNAME="administrator"
REMOTE_SERVERS_FILE="remote_servers.txt"
REMOTE_SERVER_DISTRIBUTION="$(cat /etc/os-release | grep "^NAME" | cut -d "=" -f 2)"

# Check if the remote servers file exists
if [ ! -f "$REMOTE_SERVERS_FILE" ]; then
    echo "Remote servers file $REMOTE_SERVERS_FILE not found."
    exit 1
fi

# Check the distribution and add the user to the appropriate group
if [ "$REMOTE_SERVER_DISTRIBUTION" = "Ubuntu" ]; then
    sudo usermod -aG sudo $LOCAL_USERNAME
    echo "User added to 'sudo' group."
elif [ "$REMOTE_SERVER_DISTRIBUTION" = "Rocky" ]; then
    sudo usermod -aG wheel $LOCAL_USERNAME
    echo "User added to 'wheel' group."
else
    echo "Unknown distribution. User not added to any group."
fi

# Generate SSH key pair (Ed25519) for local user
sudo ssh-keygen -t ed25519 -f "/home/$LOCAL_USERNAME/.ssh/id_ed25519" -N ""
sudo cp "/home/$LOCAL_USERNAME/.ssh/id_ed25519" "/home/administrator/certificates"

# Copy the public key to remote servers
while IFS= read -r SERVER; do
    sudo ssh-copy-id -i /home/$LOCAL_USERNAME/.ssh/id_ed25519.pub $REMOTE_USERNAME@$SERVER
done < "$REMOTE_SERVERS_FILE"

echo "Local user $LOCAL_USERNAME created and SSH keys (Ed25519) copied to remote servers."

