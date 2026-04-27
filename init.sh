#!/bin/bash
set -u

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

SCRIPT_DIR=$(dirname $(readlink -f $0))
cd "$SCRIPT_DIR"

do_chsh=0
for arg in "$@"; do
  case "$arg" in
    --chsh) do_chsh=1 ;;
    --all)  do_chsh=1 ;;
    -h|--help)
      echo "usage: $0 [--chsh] [--all]"
      echo "  --chsh   change default shell to fish"
      echo "  --all    run all steps (currently equivalent to --chsh)"
      exit 0
      ;;
    *)
      echo "${red}unknown flag: $arg${reset}" >&2
      exit 2
      ;;
  esac
done

failed=()
run_step() {
  local script=$1
  shift
  echo "${yellow}==> running ${script} $*${reset}"
  if ! ./"$script" "$@"; then
    echo "${red}${script} failed${reset}"
    failed+=("$script")
  fi
}

run_step init_vim.sh
run_step init_tmux.sh
run_step init_git.sh
run_step init_claude.sh
if [ "$do_chsh" -eq 1 ]; then
  run_step init_fish.sh --chsh
else
  run_step init_fish.sh
fi

if [ ${#failed[@]} -ne 0 ]; then
  echo "${red}finished with failures: ${failed[*]}${reset}"
  exit 1
fi

echo "${green}All set!${reset}"
