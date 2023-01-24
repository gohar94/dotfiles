#!/bin/bash
set -x

# Globals
SCRIPT_DIR=$(dirname $(readlink -f $0))

./init_vim.sh
./init_tmux.sh
./init_git.sh
