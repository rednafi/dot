#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail

# Log color.
green="\033[0;32m"
clear="\033[0m"


printf "${green}Add the Jetbrains Mono version that you want to download.${clear}\n"
printf \
"${green}You can check it here: \
https://github.com/JetBrains/JetBrainsMono/releases${clear}\n"

read font_version
echo

FONT=$(echo JetBrainsMono-{font_version}.zip | sed s/{font_version}/$font_version/g)

echo $FONT
echo

printf "${green}Downloading Jetbrains Mono...${clear}\n"

curl -OJL https://download.jetbrains.com/fonts/$FONT


printf "${green}Installing Font...${clear}\n"
sudo unzip ./$FONT -d /usr/share/fonts
sudo fc-cache -f -v

sudo rm -rf $FONT
