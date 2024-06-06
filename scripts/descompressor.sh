#!/bin/bash

: 'Information'
get_password(){
  compressed_file=$1 #hexdump data
  main_file_name="data" #the first file to be decompressed
  file_type=$(./get_hexdump_file.sh $compressed_file | grep "type" | awk '{print $2}') #gets the data type of the hex.
  if [ $file_type == "'gzip'" ]; then
    temp_files=() #Array to store the file that will be deleted."
    $(xxd -r $compressed_file > $main_file_name) #convert the hexdump data into binary file.
    decompress_file=$main_file_name 
    7z x $decompress_file > /dev/null 2>&1 #first decompression | stdin and stderr are sent to null device.
    while [ $? == "0" ]; do
      temp_files+=($decompress_file) #append the name of the current decompressed file.
      #get the name of the file that will be decompressed.
      decompress_file=$(7z l $decompress_file | grep "Name" -A2 | tail -1 | awk 'NF{print $NF}')
      7z x $decompress_file > /dev/null 2>&1 #recursive decompression.
   done
   echo "[+] The password is in: '$decompress_file' -> $(cat $decompress_file)"
   # remove the compressed files.
   for file in ${temp_files[@]}; do
     rm -f $file
   done
  fi
}

if [[ $1 ]]; then
  get_password $1
else
  echo "[!] File is missing"
fi

