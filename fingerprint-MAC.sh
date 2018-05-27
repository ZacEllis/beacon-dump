#!/bin/bash

# Makes a call to https://api.macvendors.com/vs/lookup/<MAC>

token=<redacted> # Sign up at macvendors.com to get a free token

input=$1

if [[ $input =~ ^([0-9A-F][0-9A-F]:[0-9A-F][0-9A-F]:[0-9A-F][0-9A-F]).*$ ]]; then
   sanitised=$( echo $input | sed 's/^\([0-9ABCDEF][0-9ABCDEF]\:[0-9ABCDEF][0-9ABCDEF]\:[0-9ABCDEF][0-9ABCDEF]\).*$/\1/g' )
   echo "Making call to api with '$sanitised'"
else
   echo "$input invalid, must be MAC address (or first 6 chars of MAC address in form XX:XX:XX)"
   exit 1
fi

echo $( curl -s -G "https://api.macvendors.com/v1/lookup/$sanitised" -H "Authorization: Bearer $token" -H "Accept: text/plain" )
