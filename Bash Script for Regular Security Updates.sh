#!/bin/bash

# Function to update and upgrade system packages
function update_system {
    echo "Updating system packages..."
    sudo apt-get update && sudo apt-get upgrade -y
    echo "System packages updated."
}

# Function to update antivirus definitions
function update_antivirus {
    echo "Updating antivirus definitions..."
    sudo freshclam
    echo "Antivirus definitions updated."
}

# Run the updates
update_system
update_antivirus
