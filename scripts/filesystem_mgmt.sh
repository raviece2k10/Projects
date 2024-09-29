#!/bin/bash

# Check if the user is root
if [ "$(id -u)" -ne 0 ]; then
  echo "You must be root to execute this script."
  exit 1
fi

echo "File System Management"
echo "1. Create Directory"
echo "2. Set Permissions"
echo "3. Check Disk Usage"
echo "4. Exit"

read -p "Enter your choice: " choice

case $choice in
  1)
    read -p "Enter directory name to create: " dirname
    mkdir -p $dirname && echo "Directory $dirname created."
    ;;
  2)
    read -p "Enter directory or file path: " path
    read -p "Enter permissions (e.g., 755): " permissions
    chmod $permissions $path && echo "Permissions set to $permissions for $path."
    ;;
  3)
    df -h && echo "Disk usage displayed."
    ;;
  4)
    exit 0
    ;;
  *)
    echo "Invalid option. Please try again."
    ;;
esac
