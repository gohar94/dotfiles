#!/bin/bash
set -eu

# Globals
SCRIPT_DIR=$(dirname $(readlink -f $0))

# ==================================== htop ====================================
## Backup previous htoprc
mkdir -p ~/.config/htop
if [ -f ~/.config/htop/htoprc ] && [ ! -L ~/.config/htop/htoprc ]; then
  mv ~/.config/htop/htoprc ~/.config/htop/htoprc.old
fi

## Link new htoprc (htop writes UI setting changes back through this link)
ln -sfn "$SCRIPT_DIR/htoprc" ~/.config/htop/htoprc
