#!/bin/bash
#############################################################################################################
# This script sets up the SSH key for the Administrator user on all servers.
#############################################################################################################
# File containing the list of servers
SERVERS_FILE="servers.txt"

# Check if the servers file exists and is readable
if [ ! -f "$SERVERS_FILE" ]; then
    echo "The servers file '$SERVERS_FILE' does not exist or is not readable."
    exit 1
fi

# SSH User
USER_Adm="administrator"

# Prompt user for SSH password (it will be used for all SSH connections)
read -s -p "Enter SSH password for $USER_Adm: " SSH_PASSWORD
echo

# Path to the local SSH public key
SSH_PUBLIC_KEY="$HOME/.ssh/id_ed25519.pub"

# Check if the local SSH public key exists
if [ ! -f "$SSH_PUBLIC_KEY" ]; then
    echo "Local SSH public key '$SSH_PUBLIC_KEY' does not exist."
    echo "Generate SSH key pair first using 'ssh-keygen -t ed25519' command."
    # Generate SSH Ed25519 key pair with a comment
    ssh-keygen -t ed25519 -C "Administrator@bastion"
    exit 1
fi

# Read the list of servers from the file
mapfile -t SERVERS < "$SERVERS_FILE"

# Copy the public key to remote servers
for HOST in "${SERVERS[@]}"; do
    echo "Copying public key to $HOST..."
    ssh-copy-id -i ~/.ssh/id_ed25519.pub $USER_Adm@$HOST
done

#############################################################################################################
# This script create and sets up the SSH key for the Ansible user on all servers.
#############################################################################################################

# SSH User
USER_Ansible="ansible"

#Create local user Ansible
if [ "$REMOTE_SERVER_DISTRIBUTION" = "Ubuntu" ]; then
sudo useradd ansible -m -s /bin/bash -G sudo
elif [ "$REMOTE_SERVER_DISTRIBUTION" = "Rocky" ]; then
sudo useradd ansible -m -s /bin/bash -G wheel
else
echo "Unknown distribution. User not added to any group."
fi

for HOST in "${SERVERS[@]}"; do
    echo "Creating user ansible on $HOST..."
    ssh $USER_Adm@$HOST "sudo useradd ansible -m -s /bin/bash"
    REMOTE_SERVER_DISTRIBUTION="$(ssh $USER_Adm@$HOST 'cat /etc/os-release' | grep "^NAME" | cut -d "=" -f 2 | sed 's/"//g')"
    if [ "$REMOTE_SERVER_DISTRIBUTION" = "Ubuntu" ]; then
        ssh $USER_Adm@$HOST "sudo usermod -aG sudo"
    elif [ "$REMOTE_SERVER_DISTRIBUTION" = "Rocky" ]; then
        ssh $USER_Adm@$HOST "sudo usermod -aG wheel"
    else
        echo "Unknown distribution. User not added to any group."
    fi
    ssh $USER_Ansible@$HOST "sudo mkdir /home/ansible/.ssh"
done

# Generate SSH keys for the Ansible user
sudo -u $USER_Ansible ssh-keygen -t ed25519 -C "$USER_Ansible@bastion"

# Copy the public key to the bastion host for the Ansible user
echo "Copying public key to bastion host..."
sudo -u $USER_Ansible ssh-copy-id -i /home/$USER_Ansible/.ssh/id_ed25519.pub $USER_Ansible@$HOST

# Copy the public key to remote servers for the Admin user
for HOST in "${SERVERS[@]}"; do
    echo "Copying public key to $HOST..."
    sudo -u $USER_Ansible ssh-copy-id -i /home/$USER_Ansible/.ssh/id_ed25519.pub $USER_Ansible@$HOST
done

echo "Process completed."
