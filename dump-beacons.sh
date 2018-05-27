#/bin/bash

ADAPTOR_FILE="adaptor-mode.sh"

if [ $# -ne 2 ]; then
    echo "Invalid number of arguments." 
    echo "Usage: $0 <interface> <output-prefix>"
    exit 1
fi

if [ $(id -u) -ne 0 ]; then
    echo "You don't have sufficient privileges to run this script."
    echo "Try \"sudo $0 $1 $2\""
    exit 1
fi

airmon-ng check kill

# Sets interface to monitor mode
/bin/bash $ADAPTOR_FILE $1 monitor

echo "Sleeping for a few seconds to make sure the card is up in monitor mode"
sleep 2

echo "Running airodump for 10 seconds"
timeout --kill-after=5 18 sudo airodump-ng $1 --beacons -w $2 --output-format csv 

# Sets interface back to managed mode
/bin/bash $ADAPTOR_FILE $1 managed
