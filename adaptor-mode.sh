#!/bin/bash

# Sets interface to desired mode
if [ $# -ne 2 ]; then
    echo "Invalid number of arguments." 
    echo "Usage: $0 <interface> <mode>"
    exit 1
fi

if [ $(id -u) -ne 0 ]; then
    echo "You don't have sufficient privileges to run this script."
    echo "Try \"sudo $0 $1 $2\""
    exit 1
fi

echo "Taking $1 down"
ifconfig $1 down
echo "Switching $1 to $2 mode"
iwconfig $1 mode $2
echo "Bringing $1 back up"
ifconfig $1 up  

