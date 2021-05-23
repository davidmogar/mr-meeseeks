#!/usr/bin/env bash

source "$(dirname $0)/colors.sh"

script_name=$(basename "$0")

help() {
  echo -e "Usage: ${script_name} <subcommand> [options]\n"
  echo "Subcommands:"
  echo "   destroy    Destroy Kerberos ticket"
  echo "   init       Get a new ticket"
}

subcommand_destroy() {
  kdestroy
}

subcommand_init() {
  if [ $# != 2 ]
  then
    echo "Usage ${script_name} init <ticket> <principal>"
    exit 1
  else
    [ -f "$1" ] && sudo -u "$USER" kinit -k -t $1 $2
  fi
}

subcommand_info() {
  klist -s

  if [ $? = 0 ]
  then
    echo ""
  else
    echo "${color_error}${color_reset}"
  fi
}

subcommand_name=$1
case $subcommand_name in
  "" | "-h" | "--help")
    help
    ;;
  *)
    shift
    subcommand_${subcommand_name} $@
    if [ $? = 127 ]
    then
      echo "Error: '${subcommand_name}' is not a known subcommand." >&2
      echo "       Run '${script_name} --help' for a list of known subcommands."
      exit 1
    fi
    ;;
esac
