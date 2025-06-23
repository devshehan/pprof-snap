#!/bin/bash

# ++++++++++++++++++++++++++
# pprof-fetch : Quickly fetch pprof profiles
# Author : Shehan Avishka
# Date   : 21st June 2025
# ++++++++++++++++++++++++++
# From go documentation
# - go tool pprof http://localhost:6060/debug/pprof/heap
# ++++++++++++++++++++++++++

# target pod ip
ip=$1
echo "target ip: $ip"

if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]];
then
  echo "valid ip."
else
  echo "invalid ip...try again"
  echo "./pprof-fetch <ip_address>"
  exit 1
fi

isGoInstalled=$(which go 2>/dev/null)
if [ -z "$isGoInstalled" ]; then
  echo "go needs to be installed."
  exit 1
fi
echo "go version detected..."

isDotInstalled=$(which dot 2>/dev/null)
if [ -z "$isDotInstalled" ];
then
  echo "graphviz not found. Attempting to install..."
  if ! sudo apt-get -y install graphviz; then
    echo "failed to install graphviz. exiting..."
    exit 1
  fi
fi

# server liveness check
if ping -c 1 -w 2 "$ip" &>/dev/null;
then
  echo "server $ip is alive..."
else
  echo "server $ip is not reachable..."
  exit 1
fi

# get the input number
profile="heap"

while true;
do
  echo "-----------------"
  echo "1.heap"
  echo "2.goroutine"
  echo "3.allocs"
  echo "4.threadcreate"

  read -r -p "profile number: " input

  if [[ $input =~ ^[1-4]$ ]];
  then
    if [[ $input -eq 1 ]];then
      profile="heap"
      break
    elif [[ $input -eq 2 ]];then
      profile="goroutine"
      break
    elif [[ $input -eq 3 ]]; then
      profile="allocs"
      break
    elif [[ $input -eq 4 ]]; then
      profile="threadcreate"
      break
    fi
  else
    continue
  fi
done

targetURL="http://$ip:6060/debug/pprof/$profile"
echo "target url: $targetURL"

destFilePath="$HOME/Desktop/$ip"

if [ -d "$destFilePath" ];
then
  echo "$ip file already exist."
else
  echo "$ip file not exist, file creating..."
  mkdir "$destFilePath"
fi

imageName="$(date "+%Y%m%d%H%M%S").png"
echo "image name: $imageName"

if go tool pprof -png -output="$destFilePath/$imageName" "http://$ip:6060/debug/pprof/$profile";
then
  echo "image saved in $destFilePath/$imageName"
else
  echo "something went wrong"
  exit 1
fi