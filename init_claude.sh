#!/bin/bash
set -eu

green=`tput setaf 2`
reset=`tput sgr0`

# ==================================== claude ====================================
## Install Claude Code via the official installer (skip if already present)
if command -v claude >/dev/null 2>&1 || [ -x "$HOME/.local/bin/claude" ]; then
  echo "${green}claude already installed, skipping${reset}"
else
  curl -fsSL https://claude.ai/install.sh | bash
fi

## Done
echo "${green}claude setup complete!${reset}"
