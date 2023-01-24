#!/bin/bash
set -eu

# Globals
SCRIPT_DIR=$(dirname $(readlink -f $0))

# ==================================== git ====================================
git config --global user.name "Gohar Irfan Chaudhry"
git config --global user.name "girfan@mit.edu"
git config --global core.editor "vim"
git config pull.rebase false
