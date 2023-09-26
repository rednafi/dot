#!/opt/homebrew/bin/bash

: '
    Standard functions and variables to be used by other scripts.
    Every script should source this file. Not intended to be executed directly.
'


# Set shell options for safety and clarity
set -euo pipefail

# Define some colors for output
CYAN=$(tput setaf 6)
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

# Print fancy header
function print_header() {
    echo
    local len=${#1}
    local dashes
    dashes=$(printf -- '-%.0s' $(seq 1 "$len"))

    echo -e "${CYAN}${dashes}${RESET}"
    echo -e "${CYAN}${1}${RESET}"
    echo -e "${CYAN}${dashes}${RESET}"
    echo
}

# Print an info message
function print_info() {
    echo -e "${GREEN}$1${RESET}"
}
