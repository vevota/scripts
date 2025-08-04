#!/bin/zsh

# voidpurge
# Removes orphaned and cached packages, lists all kernels, and optionally purges old kernels.

echo "Starting voidpurge..."

# Remove orphaned and cached packages (requires sudo)
echo "Removing orphaned and cached packages with xbps-remove..."
doas xbps-remove -Oo

# List all kernels (requires sudo)
echo "Listing all kernels with vkpurge:"
doas vkpurge list all

# Prompt user for confirmation, default to Y if empty input
read -p "Do you want to proceed with removing old kernels? (Y/n): " choice
set choice (string length "$choice"; or echo "Y")  # Default to Y if no input

switch "$choice"
    case "Y" "*"
        # Remove old kernels (requires sudo)
        echo "Cleaning up old kernels with vkpurge..."
        doas vkpurge rm all
        echo "Kernel cleanup completed!"
    case "N" "*"
        echo "Kernel cleanup skipped."
    case "*"
        echo "Invalid input. Exiting."
end

echo "Cleanup process completed"

