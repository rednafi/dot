#!/usr/bin/env bash

: '
    Run all the scripts. Idempotent; safe to run multiple times.
'

# shellcheck source=./lib.sh
# shellcheck source=./brew.sh
# shellcheck source=./stow.sh
# shellcheck source=./osx.sh

source ./lib.sh
source ./brew.sh
source ./stow.sh
source ./osx.sh
