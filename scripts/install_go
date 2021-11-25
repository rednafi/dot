#!/usr/bin/env bash

# Bash strict mode
set -euo pipefail

# Log color.
green="\033[0;32m"
clear="\033[0m"


printf "${green}Add the go version that you want to download.${clear}\n"
printf "${green}You can check it here: https://golang.org/dl/${clear}\n"

read go_version
echo

GO_BINARY=$(echo go{go_version}.linux-amd64.tar.gz | sed s/{go_version}/$go_version/g)

echo $GO_BINARY
echo

curl -OJL https://golang.org/dl/$GO_BINARY

echo
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $GO_BINARY
export PATH=$PATH:/usr/local/go/bin

echo
go version
echo

sudo rm -rf $GO_BINARY
