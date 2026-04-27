#!/bin/bash
set -eu

green=`tput setaf 2`
reset=`tput sgr0`

# ==================================== claude ====================================
## Install Claude Code via the official installer
curl -fsSL https://claude.ai/install.sh | bash

## Done
echo "${green}claude setup complete!${reset}"
