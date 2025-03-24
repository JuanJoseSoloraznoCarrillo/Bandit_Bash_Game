#!/bin/bash

# Globals
curr_dir=$(pwd) # return the current work directory.
_file=$1 # hold the name of the given file.

function hex2bin {
    # convert the hex data to binary data and gets the content.
    file_name="data.bin"
    _file=$1
    if [[ "${_file: -4}" == ".hex" ]]; then # file with .hex extension
        touch "$file_name"
        $(xxd -r $_file > "$file_name")
        echo "$file_name" # returns the file name as string
    fi
}

function get_bin_data {
    # unzip the file content recursivelly
    _file=$1
    7z x "$_file" 1>/dev/null # unzipping without console output
    next_file_name=$(7z l "$_file" | grep -A2 "Name" | tail -1 | awk 'NF{print $NF}') # returns the name of the zipped file.
    file_type=$(file "$next_file_name" | awk '{print $2}' FS=' ') # returns the type of the file unzipped.
    if [[ "$file_type" == "ASCII" ]]; then # if the content is a text, then get the content, otherwise, unzip the content.
        cat $next_file_name # print the text file content
        rm data* # remove all file which starts with data string
    else 
        get_bin_data $next_file_name # call recursive the method.
    fi
}
# Main
binary_file=$(hex2bin $_file)
get_bin_data $binary_file
