#!/usr/bin/env bash

source "$(dirname $0)/colors.sh"

device_regex="^([0-9A-F]{2}):([0-9A-F]{2}):([0-9A-F]{2}):([0-9A-F]{2}):([0-9A-F]{2}):([0-9A-F]{2})$"

connect() {
  [ "$(is_connected)" = 1 ] && bluetoothctl connect "$1"
}

disconnect() {
  [ "$(is_connected)" = 0 ] && bluetoothctl disconnect "$1"
}

info() {
  if [ $(is_connected) = 0 ]
  then
    echo ""
  else
    echo "${color_error}${color_reset}"
  fi
}

is_connected() {
  bluetoothctl info "$1" | grep -q "Connected: yes"
  echo $?
}

is_valid_device() {
  [[ "$1" =~ $device_regex ]]
  echo $?
}

if [ "$#" != 2 ]
then
  echo "Usage bluetooth.sh [COMMAND] [BLUETOOTH_DEVICE]"
elif [ "$(is_valid_device $2)" = 0 ]
then
  [ "$(type -t $1)" = "function" ] && eval "$1" "$2"
else
  echo "The specified device is not valid"
fi
