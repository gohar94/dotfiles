#!/bin/bash
set -eu

# Constants for use with "echo"
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# Globals
SCRIPT_DIR=$(dirname $(readlink -f $0))

./init_vim.sh
./init_tmux.sh
./init_git.sh

echo "${green}All set!${reset}"
