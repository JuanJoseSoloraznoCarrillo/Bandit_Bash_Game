#!/bin/bash
#=======================================================================================
# Author: Solorzano, Juan Jose.
# Date: 2020-07-07
# Version: 1.0
#---------------------------------------------------------------------------------------
# This script is used to extract the password from a hexdump data.
# this script is used to practice the use of the file command.
#=======================================================================================

function get_type {
  file=$1 # get the argument
  echo "Processing file: '$file'"
  temp_file=$(mktemp) #make a temporary file to print the info of the file converted.
  xxd -r "$file" > "$temp_file" #convert the hexdump file into a binary file.
  info="$(file "$temp_file")" # gets the info of the binary file.
  relevant_info=$(echo "$info" | awk '{print $2}')
  echo "[+] '$relevant_info' file type"
  rm "$temp_file" #remove the temporary file.
}
#main
if [ "$1" ]; then
  get_type "$1"
else
  echo "[!] File is missing."
fi