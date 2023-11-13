##########################################
# ZSHRC
##########################################

source ~/.zsh_aliases

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

zsh_plugins_dir=$HOME/.zsh_plugins

for plugin in $github_plugins; do
    plugin_dir=$zsh_plugins_dir/$plugin

    if [[ ! -d $plugin_dir ]]; then
        mkdir -p "$plugin_dir" && git clone --depth 1 \
            --recursive "https://github.com/$plugin.git" "$plugin_dir" > /dev/null 2>&1 &
    fi

    for initscript in ${plugin#*/}.zsh ${plugin#*/}.plugin.zsh ${plugin#*/}.sh; do
        script_path=$plugin_dir/$initscript

        [[ -f $script_path ]] && source $script_path && break
    done
done

wait

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
# Apps
##########################################

# Go
PATH=$PATH:/usr/local/go/bin

export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

# Editor
export EDITOR=micro
export VISUAL="$EDITOR"
