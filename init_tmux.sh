#!/bin/bash
set -x

# Globals
SCRIPT_DIR=$(dirname $(readlink -f $0))

# ==================================== tmux ====================================
## Backup previous tmux.conf
if [ -f ~/.tmux.conf ]; then
  mv ~/.tmux.conf ~/.tmux.conf.old
fi
## Link new tmux.conf
rm ~/.tmux.conf
ln -s $SCRIPT_DIR/tmux.conf ~/.tmux.conf
