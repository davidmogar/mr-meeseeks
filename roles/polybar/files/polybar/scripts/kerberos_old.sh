#!/usr/bin/env bash

source "$(dirname $0)/colors.sh"

if klist -s
then
   echo ""
else
   echo "${color_error}${color_reset}"
fi
