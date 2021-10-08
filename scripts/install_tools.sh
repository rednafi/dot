#!/usr/bin/env bash

# Bash strict mode.
set -euo pipefail

# Tool names.

tool_names="curl \
dnsutils \
jq \
nano \
net-tools \
telnet \
code"


# Log color.
green="\033[0;32m"
clear="\033[0m"

printf "${green}The following set of tools will be installed:${clear}\n"
printf "${green}=============================================${clear}\n"
echo
echo ${tool_names} | xargs -n1 echo "- "
echo

## Install build dependencies.
printf "${green}Installing misc tools...${clear}\n"
printf "${green}========================${clear}\n"
echo
    sudo apt install -y $tool_names
echo
