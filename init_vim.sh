#!/bin/bash
set -eu

# Constants for use with "echo"
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# Globals
SCRIPT_DIR=$(dirname $(readlink -f $0))

# ==================================== vim ====================================
## Download plugins for vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
## Backup previous vimrc
if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.old
fi

## Link new vimrc
ln -s $SCRIPT_DIR/vimrc ~/.vimrc

## Post-install instructions
echo "${green}Run :PluginInstall after opening vim for the first time${reset}"
