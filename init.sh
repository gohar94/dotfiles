#!/bin/bash
set -x

# Globals
SCRIPT_DIR=$(dirname $(readlink -f $0))

# ==================================== vim ====================================
## Download plugins for vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
## Backup previous vimrc
mv ~/.vimrc ~/.vimrc.old
## Link new vimrc
ln -s $SCRIPT_DIR/vimrc ~/.vimrc
## Post-install instructions
echo "Run :PluginInstall after opening vim for the first time"

# ==================================== tmux ====================================
## Backup previous tmux.conf
mv ~/.tmux.conf ~/.tmux.conf.old
## Link new tmux.conf
ln -s $SCRIPT_DIR/tmux.conf ~/.tmux.conf
