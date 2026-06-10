#!/bin/bash
set -eu

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

SCRIPT_DIR=$(dirname $(readlink -f $0))

do_chsh=0
for arg in "$@"; do
  case "$arg" in
    --chsh) do_chsh=1 ;;
  esac
done

# ==================================== fish ====================================
## Install fish if missing
if ! command -v fish >/dev/null 2>&1; then
  echo "${yellow}installing fish${reset}"
  if command -v brew >/dev/null 2>&1; then
    brew install fish
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y fish
  else
    echo "${red}neither brew nor apt-get found; cannot install fish${reset}"
    exit 1
  fi
fi

FISH_BIN=$(command -v fish)

## Backup previous config.fish
mkdir -p ~/.config/fish
if [ -f ~/.config/fish/config.fish ] && [ ! -L ~/.config/fish/config.fish ]; then
  mv ~/.config/fish/config.fish ~/.config/fish/config.fish.old
fi

## Link new config.fish
ln -sfn "$SCRIPT_DIR/config.fish" ~/.config/fish/config.fish

## Set default shell
if [ "$do_chsh" -eq 1 ]; then
  if ! grep -qx "$FISH_BIN" /etc/shells; then
    echo "${yellow}adding $FISH_BIN to /etc/shells${reset}"
    echo "$FISH_BIN" | sudo tee -a /etc/shells >/dev/null
  fi
  if [ "${SHELL:-}" != "$FISH_BIN" ]; then
    echo "${yellow}changing default shell to $FISH_BIN${reset}"
    chsh -s "$FISH_BIN"
  else
    echo "${green}default shell is already fish${reset}"
  fi
fi

echo "${green}fish setup complete!${reset}"
