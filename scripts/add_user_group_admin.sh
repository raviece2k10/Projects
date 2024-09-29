#!/bin/bash

# Check if the user is root
if [ "$(id -u)" -ne 0 ]; then
  echo "You must be root to execute this script."
  exit 1
fi

# Display options
echo "User and Group Administration"
echo "1. Add User"
echo "2. Delete User"
echo "3. List Users"
echo "4. Add Group"
echo "5. Delete Group"
echo "6. List Groups"
echo "7. Exit"

# Read the user's choice
read -p "Enter your choice: " choice

# Perform the appropriate task
case $choice in
  1)
    read -p "Enter the username to add: " username
    useradd $username && echo "User $username added."
    ;;
  2)
    read -p "Enter the username to delete: " username
    userdel -r $username && echo "User $username deleted."
    ;;
  3)
    echo "Listing all users:"
    cut -d: -f1 /etc/passwd
    ;;
  4)
    read -p "Enter the group name to add: " groupname
    groupadd $groupname && echo "Group $groupname added."
    ;;
  5)
    read -p "Enter the group name to delete: " groupname
    groupdel $groupname && echo "Group $groupname deleted."
    ;;
  6)
    echo "Listing all groups:"
    cut -d: -f1 /etc/group
    ;;
  7)
    exit 0
    ;;
  *)
    echo "Invalid option. Please try again."
    ;;
esac
