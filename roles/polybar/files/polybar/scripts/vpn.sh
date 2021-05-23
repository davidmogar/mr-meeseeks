#!/usr/bin/env bash

source "$(dirname $0)/colors.sh"

vpn_connections=$(nmcli connection show | grep vpn | grep -v "\-\-" | wc -l)

if [[ "$vpn_connections" -gt 0 ]]
then
   echo ""
else
   echo "${color_error}${color_reset}"
fi
