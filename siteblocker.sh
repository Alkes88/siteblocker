#!/bin/bash

# Check if a domain name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <domainname>"
    exit 1
fi

domain="$1"

# Define the lines to be added
entry1="0.0.0.0         $domain.com"
entry2="0.0.0.0         www.$domain.com"

# Check if removal is requested
if [ "$2" == "--remove" ]; then
    sudo sed -i '' "/0.0.0.0         $domain.com/d" /etc/hosts
    sudo sed -i '' "/0.0.0.0         www.$domain.com/d" /etc/hosts
    echo "The entries have been removed from /etc/hosts."
    sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
    exit 0
fi

# Check if the lines already exist in /etc/hosts
if grep -q "$entry1" /etc/hosts && grep -q "$entry2" /etc/hosts; then
    echo "The entries already exist in /etc/hosts."
    exit 0
fi

# Add the lines to /etc/hosts with sudo
echo "$entry1" | sudo tee -a /etc/hosts > /dev/null
echo "$entry2" | sudo tee -a /etc/hosts > /dev/null

echo "The entries have been added to /etc/hosts."

# Run commands to flush DNS cache and restart mDNSResponder
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder