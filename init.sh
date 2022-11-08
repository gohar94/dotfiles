#!/bin/bash
set -xe

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

mv ~/.vimrc ~/.vimrc.old
ln -s ./vimrc ~/.vimrc
