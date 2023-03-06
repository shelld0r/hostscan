#!/bin/bash

function ctrl_c(){
echo -e "\n\n[!] exiting...\n"
exit 1
}

# Ctrl+C
trap ctrl_c INT


function help_panel(){
	echo -e "\n[+] Use: "
	echo -e "\t${redColour} ${endColour} ${grayColour} hostscan [ip] ${endColour}"
}


function scan() {
  ip=$1
  echo -e "scanning.. $ip"
  for i in $(seq 1 254); do
    timeout 1 bash -c "ping -c 1 $ip$i &>/dev/null" && echo "[+] Host $ip.$i - ACTIVE" &
  done; wait
}

# function with parameters
function args() {
  ip=$1
  # validate ip
  if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
     echo "puerta de enlace: $1"
      ip=$( echo -e $1 | awk -F. '{print $1"."$2"."$3"."}' )
      scan $ip
  else
    echo -e "invalid ip"
    help_panel
  fi
}

args $1



