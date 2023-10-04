##########################################
# ZSHRC
##########################################

bindkey -e
export CLICOLOR=1

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

##########################################
# Unsets
##########################################

unset github_plugins
unset plugin
unset initscript

##########################################
# Plugins
##########################################

# Build your own cool "plugin manager".
# Based on: https://www.reddit.com/r/zsh/comments/dlmf7r/manually_setup_plugins/

github_plugins=(
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions
    zsh-users/zsh-history-substring-search

    # Must be placed in the last position.
    zsh-users/zsh-syntax-highlighting
)

# Install plugins.
for plugin in $github_plugins; do
    # Clone if not exist.
    if [[ ! -d $HOME/.zsh_plugins/$plugin ]]; then
        mkdir -p $HOME/.zsh_plugins/${plugin%/*}
        git clone --depth 1 \
            --recursive https://github.com/$plugin.git $HOME/.zsh_plugins/$plugin
    fi

    # Load the plugin.
    for initscript in ${plugin#*/}.zsh ${plugin#*/}.plugin.zsh ${plugin#*/}.sh; do
        if [[ -f $HOME/.zsh_plugins/$plugin/$initscript ]]; then
            source $HOME/.zsh_plugins/$plugin/$initscript
            break
        fi
    done
done

##########################################
# Prompt
##########################################

precmd() { print }
PS1="%{%F{yellow}%}%n@%{%f%}%{%F{yellow}%}%m:%{%F{cyan}%}% %(5~|%-1~/.../%3~|%4~)
%{%f%}$ "

# Enable interactive history sharing between tabs
setopt SHARE_HISTORY

# Append new history entries to the history file in real-time
setopt INC_APPEND_HISTORY

# Ignore duplicate commands in history
setopt HIST_IGNORE_ALL_DUPS

# Reduce multiple consecutive blank lines in history to one
setopt HIST_REDUCE_BLANKS

# Ignore duplicates when adding commands to history
setopt HIST_IGNORE_DUPS

# Ignore commands with leading whitespace in history
setopt HIST_IGNORE_SPACE

# Verify commands before executing them from history
setopt HIST_VERIFY

# Beep when accessing a nonexistent history command
setopt HIST_BEEP

##########################################
# Aliases
##########################################

# Git.
# Clears all the branches other than the current branch, 'main', 'master' & 'staging'.
alias brclr="git branch \
            | grep -vwE 'main|master|staging|development' \
            | xargs git branch -D"

# Splits the name of the current branch by '_' and picks the first token.
alias brpre="git branch --show-current | cut -d'_' -f1"

## Unix magics.
alias sudo="sudo "
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias ls="ls -G"
alias clear_cache='$ ls -d ~/Library/Caches/*/ | grep -v "com.*" | xargs -n 1 sudo rm -rf || true \
	 && sudo rm -rf ~/.cache/* || true'
alias www="python3 -m http.server 6969"


# Docker
start_redis() {
    echo "Spinning up a Redis container..."
    echo "================================"
    echo
    stop_redis
    command docker run --name dev-redis -d -h localhost -p "6379:6379" redis:alpine
    echo
}

stop_redis() {
    echo
    command docker stop dev-redis
    command docker rm dev-redis
    echo
}

alias docker-prune-containers='docker stop $(docker ps -aq) 2> /dev/null \
                            && docker rm $(docker ps -aq) 2> /dev/null'
alias docker-prune-images='docker rmi --force $(docker images -q) || true'
alias docker-nuke="docker-prune-containers \
                && docker-prune-images \
                && docker system prune -af --volumes"

##########################################
# Apps
##########################################

# Go
PATH=$PATH:/usr/local/go/bin

export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

# Editor
export EDITOR=micro
export VISUAL="$EDITOR"
