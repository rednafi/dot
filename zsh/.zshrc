##########################################
# PLUMBING
##########################################

source ~/.zsh_aliases

bindkey -e

export CLICOLOR=1

# Zsh completion settings
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

# Plugins
github_plugins=(
    zsh-users/zsh-autosuggestions
    marlonrichert/zsh-autocomplete
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-syntax-highlighting  # Must be last
)

zsh_plugins_dir="$HOME/.zsh_plugins"

# Clone plugins if not present
for plugin in $github_plugins; do
    plugin_dir="$zsh_plugins_dir/$plugin"
    if [[ ! -d $plugin_dir ]]; then
        mkdir -p "$plugin_dir" && git clone --depth 1 "https://github.com/$plugin.git" "$plugin_dir" &> /dev/null &
    fi
done
wait  # Ensures all plugins are cloned before moving on

# Load plugins if their scripts exist
LOADED_PLUGINS=""
for plugin in $github_plugins; do
    plugin_dir="$zsh_plugins_dir/$plugin"
    for initscript in ${plugin#*/}.zsh ${plugin#*/}.plugin.zsh ${plugin#*/}.sh; do
        script_path="$plugin_dir/$initscript"
        [[ -f $script_path && ! "$LOADED_PLUGINS" =~ "$script_path" ]] && source "$script_path" && LOADED_PLUGINS+="$script_path "
    done
done

# History options
setopt SHARE_HISTORY          # Enable interactive history sharing between tabs
setopt INC_APPEND_HISTORY     # Append new history entries in real-time
setopt HIST_IGNORE_ALL_DUPS   # Ignore duplicate commands
setopt HIST_REDUCE_BLANKS     # Reduce consecutive blanks
setopt HIST_IGNORE_DUPS       # Ignore duplicate entries
setopt HIST_IGNORE_SPACE      # Ignore commands with leading spaces
setopt HIST_VERIFY            # Verify commands before execution
setopt HIST_BEEP              # Beep on nonexistent history
HISTSIZE=10000                # Number of lines kept in memory
SAVEHIST=1000000              # Number of lines kept in history file

# Cd path
CDPATH="$CDPATH:$HOME/canvas"

##########################################
# PORCELAIN
##########################################

# Consolidate PATH exports
export PATH="/opt/homebrew/bin:$HOME/.local/share/uv/python:/opt/homebrew/opt/sqlite/bin:/opt/homebrew/opt/coreutils/libexec/gnubin:$HOME/go/bin:$PATH"

# Editor
export EDITOR="micro"
export VISUAL="code --wait"

# Optional sources with error handling
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || echo "Warning: ~/.fzf.zsh not found"
eval "$(direnv hook zsh)" || echo "Error: direnv hook failed"
eval "$(starship init zsh)" || echo "Error: starship initialization failed"
