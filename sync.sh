#!/bin/bash
set -eu

green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

SCRIPT_DIR=$(dirname $(readlink -f $0))
cd "$SCRIPT_DIR"

before=$(git rev-parse HEAD)
echo "${yellow}==> fetching latest dotfiles${reset}"
git pull --ff-only
after=$(git rev-parse HEAD)

if [ "$before" = "$after" ]; then
  echo "${green}already up to date${reset}"
  exit 0
fi

echo "${yellow}==> updates pulled (${before:0:7} -> ${after:0:7})${reset}"
git --no-pager log --oneline "$before..$after"

# Symlinked configs (vimrc, tmux.conf) update automatically.
# Re-run init scripts only if they changed, so we apply any new setup steps.
changed=$(git diff --name-only "$before" "$after")
if echo "$changed" | grep -qE '^init.*\.sh$'; then
  echo "${yellow}==> init scripts changed, re-running init.sh${reset}"
  ./init.sh
fi

echo "${green}sync complete!${reset}"
