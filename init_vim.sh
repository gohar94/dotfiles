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
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
## Backup previous vimrc
if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.old
fi

## Link new vimrc
ln -s $SCRIPT_DIR/vimrc ~/.vimrc

## Install
vim -E -s -u ~/.vimrc +PluginInstall! +qall

## Install the Python language server (pyright) for vim-lsp-settings.
## Replicates the plugin's own installer recipe (npm install into the servers
## dir + symlink the binary) so completion / go-to-def work out of the box
## without having to run an interactive :LspInstallServer.
PYRIGHT_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/vim-lsp-settings/servers/pyright-langserver"
if ! command -v npm >/dev/null 2>&1; then
  echo "${red}npm not found; skipping pyright install (run :LspInstallServer pyright-langserver in vim)${reset}"
elif [ -x "$PYRIGHT_DIR/pyright-langserver" ]; then
  echo "${green}pyright-langserver already installed${reset}"
else
  mkdir -p "$PYRIGHT_DIR"
  ( cd "$PYRIGHT_DIR" \
    && { [ -f package.json ] || { npm init -y >/dev/null 2>&1; echo '{"name": ""}' >package.json; }; } \
    && npm install pyright \
    && ln -sf "./node_modules/.bin/pyright-langserver" . ) \
    && echo "${green}pyright-langserver installed${reset}" \
    || echo "${red}pyright install failed; run :LspInstallServer pyright-langserver in vim${reset}"
fi

## Done
echo "${green}vim setup complete!${reset}"
