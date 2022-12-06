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

##########################################
# History
##########################################

# Set history size.
export HISTSIZE=10000

# Save history after logout.
export SAVEHIST=100000

# History file.
export HISTFILE=~/.zsh_history

# Save only one command if 2 common are same and consistent.
setopt HIST_IGNORE_DUPS

# Ignore space.
setopt HIST_IGNORE_SPACE

# Add timestamp for each entry.
setopt EXTENDED_HISTORY

# Reloads the history whenever you use it. Turn of INC_APPEND_HISTORY when this is
# turned on.
setopt SHARE_HISTORY

# Start expiring duplicate histories first.
setopt HIST_EXPIRE_DUPS_FIRST

# Whenever the user enters a line with history expansion, don’t execute the line
#directly; instead, perform history expansion and reload the line into the editing buffer.
setopt HIST_VERIFY

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

# Opens all the files changed in the current branch.
alias last_changed="git diff-tree --no-commit-id --name-only -r HEAD | xargs code"

## Unix magics.
alias sudo="sudo "
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias ls="ls -G"
alias ping="ping -c5"
alias www="python3 -m http.server 6969"

# Docker
start_redis() {
    echo "Spinning up a Redis container..."
    echo "================================"
    echo
    stop_redis
    command docker run --name dev-redis -d -h localhost -p 6379:6379 redis:7-alpine
    echo
}

stop_redis() {
    echo
    command docker stop dev-redis
    command docker rm dev-redis
    echo
}

alias docker_prune_containers='docker stop $(docker ps -aq) 2> /dev/null \
                            && docker rm $(docker ps -aq) 2> /dev/null'
alias docker_prune_images='docker rmi --force $(docker images -q) || true'
alias docker_nuke="docker_prune_containers \
                && docker_prune_images \
                && docker system prune -af --volumes"

# Workplace (Dendi).
alias dendi-restart="docker compose restart \
    lis_gunicorn lis_daphne caddy worker redis redisinsight dnsmasq"

##########################################
# Apps
##########################################

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Go
PATH=$PATH:/usr/local/go/bin
